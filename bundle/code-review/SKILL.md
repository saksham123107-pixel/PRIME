---
name: code-review
description: Multi-dimensional code review with quality gates. Use before merging any change. Review covers five axes: correctness, readability, architecture, security, and performance. Severity-labeled findings (Critical / Required / Optional / Nit) so authors know what's blocking vs optional.
license: MIT
version: 1.0.0
agent_created: true
allowed-tools: Read Grep Glob Bash
---

# Code Review and Quality / 代码审查与质量

Multi-dimensional review for any change before merge. Every change gets reviewed. No exceptions. / 合并前对任何变更做多维度审查。每个变更都要被审查，没有例外。

## The approval standard / 通过标准

Approve a change when it definitely improves overall code health, even if it isn't perfect. Perfect code doesn't exist. Don't block a change because it isn't exactly how you would have written it. If it improves the codebase and follows project conventions, approve it. / 当变更确实提升了整体代码健康度时通过，即使它不完美。完美代码不存在。不要因为不是你的写法就阻塞。如果变更提升了代码库并遵循项目约定，通过它。

## When to use / 何时使用

- Before merging any PR or change / 合并任何 PR 之前
- After completing a feature implementation / 完成功能实现后
- When another agent or model produced code you need to evaluate / 评估其他 Agent/模型生成的代码
- When refactoring existing code / 重构现有代码
- After any bug fix (review both fix and regression test) / 修任何 Bug 后（同时审查修复和回归测试）
- User says "review this", "code review", "审查代码", "审查这个 PR" / 用户说"review this"、"code review"、"审查代码"、"审查这个 PR"

## The Five-Axis Review / 五维审查

Every review evaluates code across these dimensions: / 每个审查都跨这些维度评估代码：

### 1. Correctness / 正确性

Does the code do what it claims to do? / 代码是否做了它声称要做的事？

- Matches the spec or task requirements? / 符合规范或任务要求？
- Edge cases handled (null, empty, boundary values)? / 边界情况处理了吗（null、空、边界值）？
- Error paths handled, not just happy path? / 错误路径处理了吗，不只是 happy path？
- Tests pass? Do tests actually test the right thing? / 测试通过吗？测试是否测了对的东西？
- Off-by-one errors, race conditions, state inconsistencies? / 差一错误、竞态条件、状态不一致？

### 2. Readability & Simplicity / 可读性与简洁性

Can another engineer understand this without the author explaining? / 另一个工程师能否不需要作者解释就看懂？

- Names descriptive and consistent with project conventions? (No `temp`, `data`, `result` without context) / 命名有意义、与项目约定一致？
- Control flow straightforward (avoid nested ternaries, deep callbacks)? / 控制流直接（避免嵌套三元、深度回调）？
- Related code grouped, clear module boundaries? / 相关代码分组、模块边界清晰？
- "Clever" tricks that should be simplified? / 「巧妙」技巧是否应该简化？
- Could this be done in fewer lines? (1000 lines where 100 suffice is failure) / 能用更少行吗？（100 行能搞定的写了 1000 行就是失败）
- Are abstractions earning their complexity? Don't generalize until third use case. / 抽象是否值得复杂度？不要在第三个用例之前泛化。
- New conditional bolted onto unrelated flow? That's a design smell — push logic into its own helper. / 新条件分支硬挂到无关流程？是设计气味——把逻辑提到自己的 helper。
- Repeated conditionals on same shape signal missing model or dispatcher. / 重复形状的条件分支意味着缺少模型或分发器。
- Dead code artifacts: no-op variables, backwards-compat shims, `// removed` comments. / 死代码：无用变量、向后兼容壳、`// removed` 注释。

### 3. Architecture / 架构

Does the change fit the system's design? / 变更是否符合系统设计？

- Follows existing patterns or introduces a justified new one? / 遵循现有模式，或引入合理的新模式？
- Clean module boundaries? / 模块边界清晰？
- Code duplication that should be shared? / 应该共享的代码重复？
- Dependencies flowing in right direction (no circular)? / 依赖流向正确（无循环）？
- Abstraction level appropriate (not over-engineered, not too coupled)? / 抽象层级合适（不过度设计、不过度耦合）？
- Does refactor reduce complexity or just relocate it? Count concepts a reader must hold. If "cleaner" version leaves count unchanged, it isn't cleaner — prefer the restructuring that makes whole branches, modes, or layers disappear. / 重构是降低复杂度还是搬位置？数读者需要 hold 的概念。如果「更干净」的版本数量没变，那就没更干净——优先选那种让整个分支/模式/层消失的重构。
- Feature-specific logic leaking into shared/general module? Keep logic in owning layer. / 特性专属逻辑是否泄漏到共享/通用模块？逻辑放在拥有的层。
- Type boundaries explicit? Question gratuitous `any`/`unknown`/optional/casts and silent fallbacks. / 类型边界是否显式？质疑无端 `any`/`unknown`/optional/cast 和静默回退。

### 4. Security / 安全

Does the change introduce vulnerabilities? / 变更是否引入漏洞？

- User input validated and sanitized? / 用户输入验证和清理了吗？
- Secrets out of code, logs, version control? / 密钥不在代码、日志、版本控制里？
- Authentication/authorization checked where needed? / 需要的地方做了鉴权/授权？
- SQL queries parameterized (no string concatenation)? / SQL 参数化（无字符串拼接）？
- Outputs encoded to prevent XSS? / 输出编码防止 XSS？
- Dependencies from trusted sources, no known vulnerabilities? / 依赖来自可信源，无已知漏洞？
- External data (APIs, logs, user content, config) treated as untrusted? / 外部数据（API、日志、用户内容、配置）视为不可信？
- External data validated at system boundaries before use? / 外部数据在使用前在系统边界验证了吗？

**Quick security scan** (run if available): / **快速安全扫描**（可用就跑）：

```bash
# dependency audit / 依赖审计
npm audit                          # Node
pip-audit                          # Python
go mod tidy && go list -m -u all   # Go

# secret scan / 密钥扫描
grep -rE "(api[_-]?key|secret|password|token)\s*[:=]" --include="*.{js,ts,py,go,java,rb}" .
```

### 5. Performance / 性能

Does the change introduce performance problems? / 变更是否引入性能问题？

- N+1 query patterns? / N+1 查询？
- Unbounded loops or unconstrained data fetching? / 无限循环或无约束的数据获取？
- Synchronous operations that should be async? / 应该异步的同步操作？
- Unnecessary re-renders in UI components? / UI 组件不必要的重渲染？
- Missing pagination on list endpoints? / 列表端点缺分页？
- Large objects created in hot paths? / 热路径创建大对象？

## Structural Remedies / 结构修复

When you flag a structural problem, propose the move — not just the problem. A review that only says "this is complex" leaves the author guessing. / 当你标记结构问题时，给出修复动作——不要只说问题。只说「这复杂」的审查让作者瞎猜。

Reach for a named restructuring: / 使用命名的重构动作：

- **Replace a chain of conditionals** with a typed model or explicit dispatcher / **用类型化模型或显式分发器替换条件链**
- **Collapse duplicate branches** into a single clearer flow / **折叠重复分支**为单一清晰流
- **Separate orchestration from business logic** so each reads on its own / **分离编排与业务逻辑**让各自可读
- **Move feature-specific logic** out of shared module into owning package / **把特性专属逻辑**从共享模块移到拥有的包
- **Reuse the canonical helper** instead of a bespoke near-duplicate / **复用规范 helper**而不是定制近似副本
- **Make a type boundary explicit** so downstream branching disappears / **让类型边界显式**让下游分支消失
- **Delete a pass-through wrapper** that adds indirection without clarifying API / **删除传递包装**只增间接不澄清 API
- **Extract a helper, or split a large file** into focused modules / **提取 helper，或拆分大文件**为聚焦模块

Prefer the remedy that removes moving pieces over one that spreads the same complexity around. / 优先选消除移动部件的修复，而不是把同样复杂度摊开。

## Change Sizing / 变更规模

Small focused changes are easier to review, faster to merge, safer to deploy. / 小而聚焦的变更更易审查、更快合并、更安全部署。

```
~100 lines changed   → Good. Reviewable in one sitting.
                       好。一次性能审完。
~300 lines changed   → Acceptable if single logical change.
                       可接受（如果是一个逻辑变更）。
~1000 lines changed  → Too large. Split it.
                       太大。拆开。
```

**Watch file size, not just diff size.** Around 1000 *total* lines in a single file is a common inspection signal. When a change grows an already-large file, ask whether to extract helpers, subcomponents, or modules *first*. / **看文件大小，不只看 diff 大小**。单文件 ~1000 行总行数是常见检查信号。变更让已大文件更大时，先问要不要先拆。

**Splitting strategies / 拆分策略**:

| Strategy | How | When |
|---|---|---|
| **Stack** 堆叠 | Submit small change, start next based on it / 提交小变更，下一个基于它 | Sequential dependencies / 顺序依赖 |
| **By file group** 按文件分组 | Separate changes for groups needing different reviewers / 分组给不同审查者 | Cross-cutting concerns / 横切关注点 |
| **Horizontal** 横向 | Create shared code/stubs first, then consumers / 先建共享代码/桩，再用 | Layered architecture / 分层架构 |
| **Vertical** 纵向 | Break into smaller full-stack slices / 拆为更小的全栈切片 | Feature work / 功能工作 |

**Separate refactoring from feature work.** Refactor + new behavior = two changes. Submit separately. / **重构与功能变更分离提交**。

## Severity labels / 严重程度标签

Label every comment so the author knows what's required vs optional. / 给每个评论打标，让作者知道哪些必改哪些可选。

| Prefix | Meaning | Author Action |
|---|---|---|
| *(no prefix)* / 无前缀 | **Required** change / 必改 | Must address before merge / 合并前必须处理 |
| **Critical:** / 严重 | Blocks merge / 阻塞合并 | Security vulnerability, data loss, broken functionality / 安全漏洞、数据丢失、功能损坏 |
| **Required:** / 必改 | Must fix before merge / 合并前必改 | Logic bug, missed requirement, broken test / 逻辑 Bug、漏需求、测试坏 |
| **Optional:** / 建议 | Suggestion / 建议 | Worth considering but not required / 值得考虑但不强制 |
| **Nit:** / 细节 | Minor, optional / 小问题可选 | Formatting, naming preferences / 格式、命名偏好 |
| **FYI** / 备忘 | Informational only / 仅作备忘 | Context for future reference / 留作日后参考 |

**Lead with what matters.** Order findings by leverage: correctness + security first, then structural regressions + missed simplifications, then everything else. Don't bury a real issue under cosmetic nits. A few high-conviction comments beat a long list. / **把重要的放前面**。按影响力排序：正确性+安全优先，然后结构性回归+可简化点，然后其他。不要把真问题埋在细节下。

## Review Process / 审查流程

### Step 1: Understand context / 第一步：理解上下文

```
- What is this change trying to accomplish? / 变更要达成什么？
- What spec or task does it implement? / 它实现哪个规范/任务？
- What is the expected behavior change? / 期望的行为变更是什么？
```

### Step 2: Review the tests first / 第二步：先看测试

Tests reveal intent and coverage: / 测试揭示意图和覆盖度：

```
- Do tests exist? / 有测试吗？
- Do they test behavior (not implementation details)? / 测的是行为（不是实现细节）？
- Are edge cases covered? / 边界覆盖了吗？
- Do tests have descriptive names? / 测试名有意义吗？
- Would tests catch a regression if code changed? / 代码改了测试能抓到吗？
```

### Step 3: Review the implementation / 第三步：审查实现

Walk through with five axes in mind. See the Five-Axis Review above. / 用五维走查。见上。

### Step 4: Categorize findings / 第四步：分类发现

Apply severity labels. Lead with what matters. / 打严重程度标签。把重要的放前面。

### Step 5: Verify the verification / 第五步：核实验证

Check the author's verification story: / 检查作者的验证故事：

```
- What tests were run? / 跑了哪些测试？
- Did the build pass? / 构建通过吗？
- Was the change tested manually? / 手动测了吗？
- Screenshots for UI changes? / UI 变更截图了吗？
- Before/after comparison? / 前后对比了吗？
```

## Output: Review Report / 输出：审查报告

Output format (use this template): / 输出格式（用这个模板）：

```markdown
## Review: [PR/Change title]

### Context
- [ ] I understand what this change does and why / 我理解变更做什么、为什么

### Correctness / 正确性
- [ ] Change matches spec / 符合规范
- [ ] Edge cases handled / 边界处理
- [ ] Error paths handled / 错误路径处理
- [ ] Tests adequate / 测试充分

### Readability / 可读性
- [ ] Names clear / 命名清晰
- [ ] Logic straightforward / 逻辑直接
- [ ] No unnecessary complexity / 无不必要复杂度

### Architecture / 架构
- [ ] Follows existing patterns / 遵循模式
- [ ] No unnecessary coupling / 无多余耦合
- [ ] Appropriate abstraction / 抽象合适
- [ ] Refactors reduce complexity / 重构降复杂度

### Security / 安全
- [ ] No secrets in code / 代码无密钥
- [ ] Input validated / 输入验证
- [ ] No injection vulnerabilities / 无注入漏洞
- [ ] Auth checks / 鉴权检查
- [ ] External data treated as untrusted / 外部数据不可信

### Performance / 性能
- [ ] No N+1 / 无 N+1
- [ ] No unbounded operations / 无无限操作
- [ ] Pagination on lists / 列表分页

### Verification / 验证
- [ ] Tests pass / 测试过
- [ ] Build succeeds / 构建成
- [ ] Manual verification / 手动验证

### Findings / 发现
**Critical:** [list] / 严重：[列出]
**Required:** [list] / 必改：[列出]
**Optional:** [list] / 建议：[列出]
**Nit:** [list] / 细节：[列出]
**FYI:** [list] / 备忘：[列出]

### Verdict / 结论
- [ ] **Approve** — Ready to merge / 通过——可合并
- [ ] **Request changes** — Issues must be addressed / 请求变更——必须处理
```

## Common Rationalizations / 常见合理化借口

| Rationalization / 借口 | Reality / 真相 |
|---|---|
| "It works, that's good enough" / 「能跑就行」 | Working code that's unreadable, insecure, or architecturally wrong creates compounding debt. / 能跑但难读、不安全、架构错的代码会产生复合债务。 |
| "I wrote it, so I know it's correct" / 「我写的，我肯定对」 | Authors are blind to their own assumptions. Every change benefits from another set of eyes. / 作者对自己的假设盲。 |
| "We'll clean it up later" / 「之后清理」 | Later never comes. Require cleanup before merge, not after. / 之后永远不会来。合并前要求清理，不是合并后。 |
| "AI-generated code is probably fine" / 「AI 生成的应该没问题」 | AI code needs MORE scrutiny, not less. It's confident and plausible, even when wrong. / AI 代码需要更多审查，不是更少。 |
| "The tests pass, so it's good" / 「测试过就行」 | Tests are necessary but not sufficient. They don't catch architecture, security, readability issues. / 测试必要但不充分。 |
| "The refactor makes it cleaner" / 「重构更干净」 | Relocating complexity isn't reducing it. Count concepts reader holds. / 搬位置不是降复杂度。 |
| "It's only a small addition to this file" / 「只是给这个文件小加一点」 | Small diffs still push files past healthy size. Judge resulting structure, not diff size. / 小 diff 也让文件超出健康大小。看结果结构，不看 diff 大小。 |
| "It's just a version bump" / 「只是版本号 bump」 | A bump is a behavior change you didn't write. Read the changelog. / Bump 是你没写的行为变更。读 changelog。 |

## Red Flags / 红旗

- PRs merged without any review / 没审查就合并的 PR
- Review that only checks if tests pass / 只查测试通过的审查
- "LGTM" without evidence of actual review / 没证据就 LGTM
- Security-sensitive changes without security-focused review / 安全敏感变更没做安全审查
- Large PRs "too big to review properly" / 太大 PR「没法好好审」
- No regression tests with bug fix PRs / 修 Bug PR 没回归测试
- Review comments without severity labels / 审查评论无严重程度标签
- Accepting "I'll fix it later" / 接受「之后修」
- Refactor that moves code around without reducing concepts / 搬代码不降概念数的重构
- Change growing already-large file without decomposition / 让已大文件更大的变更不拆分
- New conditionals scattered into unrelated paths / 新条件分支散到无关路径
- Bespoke helper duplicating canonical one / 定制 helper 复制了规范的那个
- Bulk "bump dependencies" with no changelog review / 批量「bump 依赖」没看 changelog

## Dead Code Hygiene / 死代码卫生

After any refactoring or implementation change, check for orphaned code: / 任何重构或实现变更后，检查孤儿代码：

1. Identify code that's now unreachable or unused / 识别现在不可达或不用的代码
2. List it explicitly / 明确列出
3. **Ask before deleting** / **删之前先问**："Should I remove these now-unused elements: [list]?"

Don't silently delete things you're not sure about. When in doubt, ask. / 没把握不要默默删。不确定就问。

## Honesty in Review / 审查中的诚实

- **Don't rubber-stamp.** "LGTM" without evidence helps no one. / **不要走过场**。
- **Don't soften real issues.** "This might be a minor concern" when it's a production bug is dishonest. / **不要软化真问题**。
- **Quantify when possible.** "This N+1 will add ~50ms per item" beats "this could be slow." / **能量化就量化**。
- **Push back on approaches with clear problems.** Sycophancy is a failure mode. / **对明确有问题的方案要顶回去**。
- **Accept override gracefully.** If author has full context and disagrees, defer. Comment on code, not people. / **优雅接受推翻**。

## Verification before completion / 完成前验证

- [ ] All Critical issues resolved / 所有严重问题解决
- [ ] All Required (no-prefix) changes resolved or explicitly deferred with justification / 所有必改解决或明确推迟
- [ ] Tests pass / 测试过
- [ ] Build succeeds / 构建成
- [ ] Verification story documented / 验证故事记录

## See Also / 参见

- [references/security-checklist.md](references/security-checklist.md) — Full OWASP Top 10 checklist / 完整 OWASP Top 10 检查表
- [references/performance-checklist.md](references/performance-checklist.md) — Performance review deep dive / 性能审查深入

## Compatibility notes / 兼容性说明

- **Works with any diff source**: git diff, GitHub PR, GitLab MR, Bitbucket PR, or pasted code. / 适用于任何 diff 来源：git diff、GitHub PR、GitLab MR、Bitbucket PR 或粘贴的代码。
- **Severity vocabulary unified** with industry-standard (Critical/Required/Optional/Nit) so reviews map cleanly across teams. / 严重程度词汇统一为业界标准（Critical/Required/Optional/Nit），跨团队审查映射清晰。
- **No tool dependency**: review itself needs no special tool. Security scan commands above are best-effort. / 无工具依赖：审查本身不需要特殊工具。上面安全扫描命令是尽力而为。