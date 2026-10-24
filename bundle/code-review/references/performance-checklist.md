# Performance Review Checklist / 性能审查检查表

Deep-dive performance checks for code review. Use this when the performance axis of code review needs depth. / 代码审查性能维度的深入检查。性能维度需要深入时用。

## When to use / 何时使用

- Reviewing changes that touch hot paths (login, checkout, search, feed, API endpoints serving many users) / 审查触及热路径的变更（登录、结账、搜索、feed、服务大量用户的 API 端点）
- Reviewing changes that add database queries, network calls, or loops over large data / 审查加数据库查询、网络调用或大循环的变更
- Reviewing UI changes that affect perceived performance (initial load, navigation, large lists) / 审查影响感知性能的 UI 变更（初始加载、导航、大列表）
- Before any release that expects traffic spike / 预期流量峰值的任何发布前

## Categories / 分类

### 1. Database queries / 数据库查询

#### N+1 queries / N+1 查询

The most common performance bug. ORM or naive code issues 1 query per item instead of 1 query for the batch. / 最常见的性能 Bug。ORM 或朴素代码每个 item 一次查询，而非整批一次。

```js
// BAD: N+1 / 反例
const users = await db.query('SELECT * FROM users LIMIT 100');
for (const user of users) {
  user.posts = await db.query('SELECT * FROM posts WHERE user_id = ?', [user.id]);
}
// = 1 + 100 = 101 queries

// GOOD: JOIN / 正例
const usersWithPosts = await db.query(`
  SELECT users.*, posts.*
  FROM users
  LEFT JOIN posts ON posts.user_id = users.id
  LIMIT 100
`);
// = 1 query
```

Detection: / 检测：
- `grep -rE "for.*await.*query\(" --include="*.{js,ts,py,go}"`
- ORM-specific: count queries per request with `pg_stat_statements` or ORM debug log / ORM 专用：用 `pg_stat_statements` 或 ORM debug log 计数

#### Missing indexes / 缺失索引

- Queries with WHERE, ORDER BY, JOIN ON columns should have indexes / 带 WHERE、ORDER BY、JOIN ON 列的查询应该有索引
- EXPLAIN the query and check Seq Scan vs Index Scan / 用 EXPLAIN 看查询，检查 Seq Scan vs Index Scan

```sql
-- Check missing index / 检查缺失索引
EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 123 ORDER BY created_at DESC;
-- Look for "Seq Scan on orders" = full table scan = missing index
```

#### SELECT * / SELECT *

```js
// BAD: SELECT * fetches all columns even if you use 1 / SELECT * 取所有列，即使只用 1
const user = await db.query('SELECT * FROM users WHERE id = ?', [id]);

// GOOD: explicit columns / 显式列
const user = await db.query('SELECT id, name, email FROM users WHERE id = ?', [id]);
```

#### Unbounded result sets / 无界结果集

```js
// BAD: no LIMIT / 无 LIMIT
const logs = await db.query('SELECT * FROM logs');

// GOOD: paginate or LIMIT / 分页或 LIMIT
const logs = await db.query('SELECT * FROM logs ORDER BY created_at DESC LIMIT 100');
```

### 2. Network calls / 网络调用

#### Waterfalls (sequential awaits) / 瀑布流（顺序 await）

```js
// BAD: sequential / 顺序
const user = await fetchUser(id);
const orders = await fetchOrders(id);     // waits for user first
const prefs = await fetchPrefs(id);        // waits for orders first

// GOOD: parallel / 并行
const [user, orders, prefs] = await Promise.all([
  fetchUser(id),
  fetchOrders(id),
  fetchPrefs(id),
]);
```

Detection: count awaits in sequence that don't depend on each other. / 检测：数顺序中相互不依赖的 await。

#### Per-item API calls in a loop / 循环中每项一次 API

```js
// BAD: 1 API call per item / 每项一次 API
const enrichedUsers = await Promise.all(
  users.map(u => fetch(`/api/users/${u.id}/details`).then(r => r.json()))
);
// = N API calls

// GOOD: bulk endpoint / 批量端点
const allDetails = await fetch('/api/users/details?ids=' + users.map(u => u.id).join(','))
  .then(r => r.json());
```

#### Synchronous I/O in async contexts / 异步上下文里的同步 I/O

```js
// BAD: sync read in async handler / 异步 handler 里同步读
app.get('/data', async (req, res) => {
  const data = fs.readFileSync('huge.json');   // blocks event loop
  res.json(data);
});

// GOOD: async read / 异步读
app.get('/data', async (req, res) => {
  const data = await fs.promises.readFile('huge.json');
  res.json(data);
});
```

### 3. Loops & algorithms / 循环与算法

#### O(n²) when O(n) or O(n log n) exists / O(n²) 能优化为 O(n) 或 O(n log n)

```js
// BAD: nested loop = O(n²)
for (const a of list) {
  for (const b of list) {
    if (a.id === b.parentId) { /* ... */ }
  }
}

// GOOD: hash map = O(n)
const byParent = new Map();
for (const b of list) {
  if (!byParent.has(b.parentId)) byParent.set(b.parentId, []);
  byParent.get(b.parentId).push(b);
}
for (const a of list) {
  const children = byParent.get(a.id) ?? [];
  // ...
}
```

#### Unbounded loops / 无限循环

```js
// BAD: no termination condition / 无终止条件
while (true) {
  const next = await fetchNext();
  if (!next) break;
}

// GOOD: explicit limit + timeout / 显式限制 + 超时
const start = Date.now();
let count = 0;
while (count < MAX_ITEMS && Date.now() - start < MAX_MS) {
  const next = await fetchNext();
  if (!next) break;
  count++;
}
```

### 4. Memory / 内存

#### Loading huge data in memory / 一次性加载大数据到内存

```js
// BAD: load 10GB into memory / 把 10GB 加载到内存
const allRows = await db.query('SELECT * FROM huge_table');

// GOOD: stream / 流式处理
const stream = db.queryStream('SELECT * FROM huge_table');
for await (const row of stream) {
  // process one at a time
}
```

#### Memory leaks (event listeners, timers, caches) / 内存泄漏（事件监听、定时器、缓存）

```js
// BAD: listeners never removed / 监听器永不删除
emitter.on('data', handler);

// GOOD: removed on cleanup / 清理时删除
emitter.on('data', handler);
cleanup.push(() => emitter.off('data', handler));
```

#### Unbounded cache growth / 缓存无限增长

```js
// BAD: cache never evicts / 缓存永不淘汰
const cache = new Map();

// GOOD: LRU with max size / LRU + 最大大小
const cache = new LRU({ max: 1000 });
```

### 5. Frontend & UI / 前端与 UI

#### Unnecessary re-renders / 不必要重渲染

```jsx
// BAD: new object every render → child re-renders / 每次渲染新对象 → 子组件重渲染
<List items={items.filter(x => x.active)} />

// GOOD: memoize / memo
const activeItems = useMemo(() => items.filter(x => x.active), [items]);
<List items={activeItems} />
```

#### Large lists without virtualization / 大列表不虚拟化

```jsx
// BAD: render 10,000 items / 渲染 10,000 项
{items.map(item => <Row key={item.id} item={item} />)}

// GOOD: virtualize / 虚拟化
import { VirtualList } from 'react-virtual';
<VirtualList itemCount={items.length} itemSize={50} renderItem={({index}) => <Row item={items[index]} />} />
```

#### Bundle size / 包大小

- Adding a 200KB dep for a 5-line utility? Reconsider. / 加 200KB 依赖只为 5 行工具？重考虑。
- Tree-shaking configured? / 配置了树-shaking？
- Code-splitting for routes? / 路由代码分割？

```bash
# Check bundle / 检查包
npm run build -- --stats
npx webpack-bundle-analyzer stats.json

# Or for Vite:
npx vite-bundle-visualizer
```

#### Image optimization / 图片优化

- Images served at correct size (don't ship 4000px image for 200px display)? / 图片按正确尺寸服务（200px 显示别传 4000px 图）？
- Modern formats (WebP, AVIF) where supported? / 支持时用现代格式（WebP、AVIF）？
- Lazy loading for offscreen images? / 屏外图片懒加载？

### 6. Caching / 缓存

- Hot data cached? / 热数据缓存？
- Cache invalidation strategy clear? / 缓存失效策略清晰？
- Cache stampede prevented (lock for single-flight)? / 防缓存击穿（单飞锁）？
- Stale-while-revalidate for read-heavy? / 读多用 stale-while-revalidate？

### 7. Concurrency / 并发

- Race conditions on shared state? / 共享状态竞态？
- Atomic operations where needed? / 必要时原子操作？
- Connection pool sized appropriately? / 连接池大小合适？
- Lock granularity right (not too coarse, not too fine)? / 锁粒度合适（不过粗不过细）？

## Quick profiling commands / 快速性能剖析命令

```bash
# Node / Node
node --prof app.js
node --prof-process isolate-*.log | head -30

# Python / Python
python -m cProfile -o profile.stats app.py
python -c "import pstats; p = pstats.Stats('profile.stats'); p.sort_stats('cumulative').print_stats(20)"

# Go / Go
go test -bench=. -benchmem
go tool pprof http://localhost:6060/debug/pprof/profile

# Browser / 浏览器
# Chrome DevTools → Performance tab → record
# Or Lighthouse for end-to-end audit

# Network / 网络
curl -w "@-" -o /dev/null http://localhost:3000/api/endpoint <<'EOF'
time_namelookup: %{time_namelookup}\n
time_connect: %{time_connect}\n
time_total: %{time_total}\n
EOF
```

## Output: Performance findings in code review / 输出：代码审查中的性能发现

```markdown
**Performance Finding:** [Category — N+1 / Network waterfall / Loop complexity / etc.]
**Severity:** [Critical / Required / Optional / FYI]
**Location:** [file:line]
**Issue:** [what's wrong]
**Impact:** [quantified if possible — "adds ~50ms per item × 100 items = 5s"]
**Fix:** [recommended optimization]
**Reference:** [link to technique or doc]
```

Example: / 示例：

```markdown
**Performance Finding:** Database — N+1 query
**Severity:** Required
**Location:** src/users/service.ts:24-30
**Issue:** Loop issues 1 query per user to fetch posts.
**Impact:** ~100ms × 100 users = 10s per request.
**Fix:** Replace with single JOIN query (see code below).
**Reference:** https://stackoverflow.com/q/97197 (or relevant ORM doc)
```

## When to escalate / 何时升级

- **Critical**: data loss, system unavailable, security regression caused by performance (DoS). / **严重**：数据丢失、系统不可用、性能引发的安全回归（DoS）。
- **Required**: clear measurable impact on user-facing flow. / **必改**：对用户流程有可测量的影响。
- **Optional**: theoretical concern, no immediate impact, defer to backlog. / **建议**：理论问题，无即时影响，延到 backlog。
- **FYI**: educational, no action needed. / **备忘**：教育性，无需行动。

## See also / 参见

- [Web Vitals](https://web.dev/vitals/) — Core Web Vitals for frontend / 前端 Core Web Vitals
- [PostgreSQL EXPLAIN](https://www.postgresql.org/docs/current/using-explain.html) — Query planning / 查询规划
- [High Performance Browser Networking](https://hpbn.co/) — Network performance / 网络性能

## Compatibility notes / 兼容性说明

- **No project dependency**: works in any codebase. / 无项目依赖。
- **No tool dependency**: methodology + best-effort commands. / 无工具依赖。
- **Severity vocabulary unified** with `code-review-and-quality`. / 严重程度词汇与 `code-review-and-quality` 统一。