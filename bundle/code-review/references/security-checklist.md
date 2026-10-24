# Security Review Checklist / 安全审查检查表

Comprehensive security checks aligned with OWASP Top 10 (2021). Use this as a depth reference when the security axis of code review finds something. / 与 OWASP Top 10 (2021) 对齐的全面安全检查。代码审查安全维度发现问题时的深入参考。

## When to use / 何时使用

- Reviewing any change touching user input, auth, data access, or external integrations / 审查任何涉及用户输入、鉴权、数据访问或外部集成的变更
- Reviewing new dependencies / 审查新依赖
- After any incident or near-miss / 任何事件或险情后
- Periodic security audit / 定期安全审计

## OWASP Top 10 (2021) — Review Checklist / OWASP Top 10 (2021) — 审查检查表

### A01: Broken Access Control / 失效的访问控制

- [ ] Authentication required on all protected routes? / 所有受保护路由有鉴权？
- [ ] Authorization checked after auth? / 鉴权后做了授权？
- [ ] Direct object references protected (IDOR prevention)? / 直接对象引用受保护（防 IDOR）？
- [ ] Role-based access enforced, not client-side only? / 基于角色的访问强制执行，不只客户端？
- [ ] CORS configured to allow only known origins? / CORS 配置为只允许已知来源？
- [ ] JWT/session tokens have short expiry, refresh flow? / JWT/session token 短过期、有刷新流程？

```ts
// BAD: trusting client-provided user ID / BAD：信任客户端用户 ID
app.get('/orders/:userId', (req, res) => {
  const orders = db.getOrdersByUser(req.params.userId);  // IDOR
});

// GOOD: derive user from authenticated session / GOOD：从认证会话派生用户
app.get('/orders', (req, res) => {
  const orders = db.getOrdersByUser(req.session.userId);
});
```

### A02: Cryptographic Failures / 加密失败

- [ ] Passwords hashed with bcrypt/argon2/scrypt (not MD5/SHA1)? / 密码用 bcrypt/argon2/scrypt 哈希（不用 MD5/SHA1）？
- [ ] Sensitive data encrypted at rest? / 敏感数据静态加密？
- [ ] Sensitive data encrypted in transit (HTTPS only)? / 敏感数据传输加密（仅 HTTPS）？
- [ ] API keys/secrets in env vars or secret manager, not code? / API key/密钥在环境变量或密钥管理器，不在代码？
- [ ] HTTPS enforced (HSTS, redirect HTTP → HTTPS)? / HTTPS 强制（HSTS、HTTP → HTTPS 重定向）？
- [ ] TLS config: TLS 1.2+ only, no weak ciphers? / TLS 配置：仅 TLS 1.2+，无弱密码？

### A03: Injection (SQL, NoSQL, Command) / 注入（SQL、NoSQL、命令）

- [ ] SQL queries parameterized (no string concatenation)? / SQL 参数化（无字符串拼接）？
- [ ] ORM used correctly (no raw queries with user input)? / ORM 正确使用（无带用户输入的原始查询）？
- [ ] NoSQL queries use operator objects, not string concat? / NoSQL 用操作符对象，不用字符串拼接？
- [ ] OS commands use exec with array args (no shell concat)? / OS 命令用 exec + 数组参数（无 shell 拼接）？
- [ ] LDAP queries use parameter binding? / LDAP 用参数绑定？

```sql
-- BAD: string concatenation / 字符串拼接
query = "SELECT * FROM users WHERE name = '" + userName + "'"

-- GOOD: parameterized query / 参数化
query = "SELECT * FROM users WHERE name = ?"
db.execute(query, [userName])
```

### A04: Insecure Design / 不安全设计

- [ ] Threat model considered for new features? / 新功能考虑了威胁模型？
- [ ] Rate limiting on sensitive endpoints (login, password reset, payments)? / 敏感端点限速（登录、密码重置、支付）？
- [ ] Business logic has abuse cases considered? / 业务逻辑考虑了滥用情况？
- [ ] Audit logging on sensitive operations? / 敏感操作审计日志？
- [ ] Defense in depth (validation at multiple layers)? / 纵深防御（多层验证）？

### A05: Security Misconfiguration / 安全配置错误

- [ ] Default credentials changed? / 默认凭据改了？
- [ ] Unnecessary features disabled (debug, sample apps, admin panels)? / 不必要功能禁用（debug、示例 app、admin 面板）？
- [ ] Error messages don't leak stack traces or sensitive info? / 错误消息不泄露 stack trace 或敏感信息？
- [ ] Security headers set (CSP, X-Frame-Options, X-Content-Type-Options)? / 安全头设置（CSP、X-Frame-Options、X-Content-Type-Options）？
- [ ] Dependencies up to date, no known vulns? / 依赖最新，无已知漏洞？
- [ ] Cloud storage permissions minimal (S3 buckets not public)? / 云存储权限最小（S3 bucket 不公开）？

### A06: Vulnerable & Outdated Components / 脆弱和过时组件

- [ ] Dependency scan run (`npm audit`, `pip-audit`, `snyk`)? / 依赖扫描跑过（`npm audit`、`pip-audit`、`snyk`）？
- [ ] Lockfile committed, not hand-edited? / lockfile 提交，未手工编辑？
- [ ] Dependencies from trusted sources, not typosquatted? / 依赖来自可信源，非仿冒？
- [ ] Transitive dependency review (lockfile diff)? / 传递依赖审查（lockfile diff）？

```bash
# Run regularly / 定期跑
npm audit                       # Node
pip-audit                       # Python
snyk test                       # Cross-platform / 跨平台
go list -m -u all               # Go
```

### A07: Identification & Authentication Failures / 身份和认证失败

- [ ] Password complexity requirements enforced? / 强制密码复杂度？
- [ ] Account lockout after N failed attempts? / N 次失败后账户锁定？
- [ ] Multi-factor auth for sensitive operations? / 敏感操作多因子认证？
- [ ] Session ID regenerated after login (prevent fixation)? / 登录后 session ID 重新生成（防固定）？
- [ ] httpOnly, Secure, SameSite flags on session cookies? / session cookie 有 httpOnly、Secure、SameSite？
- [ ] CSRF protection on state-changing requests? / 状态变更请求有 CSRF 保护？

### A08: Software & Data Integrity Failures / 软件和数据完整性失败

- [ ] CI/CD pipeline verifies integrity (signed commits, signed artifacts)? / CI/CD 流水线验证完整性（签名提交、签名制品）？
- [ ] Auto-update mechanism verifies signatures? / 自动更新机制验证签名？
- [ ] Deserialization uses safe format (JSON, not Java native if avoidable)? / 反序列化用安全格式（JSON，能免则免 Java native）？
- [ ] Webhook signatures verified? / Webhook 签名验证？

### A09: Security Logging & Monitoring Failures / 安全日志和监控失败

- [ ] Login attempts logged? / 登录尝试记录？
- [ ] Access control failures logged? / 访问控制失败记录？
- [ ] Input validation failures logged? / 输入验证失败记录？
- [ ] Logs include sufficient context (user ID, IP, timestamp)? / 日志包含足够上下文（用户 ID、IP、时间戳）？
- [ ] Logs stored separately from app (can't be tampered via app)? / 日志与应用分离存储（应用不能篡）？
- [ ] Alerts configured for suspicious patterns? / 可疑模式有告警？

### A10: Server-Side Request Forgery (SSRF) / 服务端请求伪造

- [ ] Outbound HTTP from server validates destination? / 服务端出站 HTTP 验证目的地？
- [ ] Internal IPs blocked from outbound requests (10.x, 192.168.x, 169.254.x)? / 内部 IP 禁止出站（10.x、192.168.x、169.254.x）？
- [ ] URL schemes restricted (no `file://`, `gopher://`)? / URL scheme 限制（无 `file://`、`gopher://`）？
- [ ] DNS resolution validated against allowlist? / DNS 解析对照白名单验证？

```ts
// BAD: fetch user-provided URL directly / 直接拉用户提供的 URL
const response = await fetch(req.body.url);

// GOOD: validate URL against allowlist + block internal IPs / 对照白名单验证 + 阻塞内部 IP
const parsed = new URL(req.body.url);
if (!ALLOWED_HOSTS.has(parsed.hostname)) throw new Error('forbidden');
if (isInternalIP(parsed.hostname)) throw new Error('forbidden');
const response = await fetch(parsed.toString());
```

## Quick security scan commands / 快速安全扫描命令

```bash
# Secrets in code / 代码中的密钥
grep -rE "(api[_-]?key|secret|password|token|aws[_-]access)" \
  --include="*.{js,ts,py,go,java,rb,rs}" \
  --exclude-dir={node_modules,venv,.git} .

# SQL injection patterns / SQL 注入模式
grep -rE "(SELECT|INSERT|UPDATE|DELETE).*\+.*req\." \
  --include="*.{js,ts}" .
grep -rE "f\".*SELECT.*\{.*\}" --include="*.py" .

# Dangerous functions / 危险函数
grep -rE "\b(eval|exec|Function)\s*\(" --include="*.{js,ts}" .
grep -rE "subprocess\.call\(.*shell=True" --include="*.py" .

# Outdated dependencies / 过时依赖
npm audit
pip-audit
go mod tidy && go list -m -u all
```

## Output: Security findings in code review / 输出：代码审查中的安全发现

Format security findings as: / 安全发现格式：

```markdown
**Security Finding:** [OWASP category]
**Severity:** [Critical / Required / Optional / FYI]
**Location:** [file:line]
**Issue:** [what's wrong]
**Risk:** [what an attacker could do]
**Fix:** [recommended remediation]
**Reference:** [OWASP link or related]
```

Example: / 示例：

```markdown
**Security Finding:** A03 — Injection (SQL)
**Severity:** Critical
**Location:** src/orders/repo.ts:42
**Issue:** User-controlled `orderId` concatenated into SQL query.
**Risk:** Attacker could exfiltrate arbitrary data via UNION SELECT.
**Fix:** Use parameterized query:
  `db.query('SELECT * FROM orders WHERE id = ?', [orderId])`
**Reference:** https://owasp.org/Top10/A03_2021-Injection/
```

## When to escalate / 何时升级

- **Critical** finding (data loss, auth bypass, injection): block merge, require fix before re-review. / **严重**发现（数据丢失、鉴权绕过、注入）：阻塞合并，要求修复后重新审查。
- **Required** finding (missing validation, weak crypto): must fix before merge. / **必改**发现（缺验证、弱加密）：合并前必修。
- **Optional** finding (best practice not followed): defer to backlog with self-assignment. / **建议**发现（未遵循最佳实践）：延到 backlog，自己认领。
- **FYI** (informational): no action needed. / **备忘**：不需要行动。

## See also / 参见

- [OWASP Top 10](https://owasp.org/Top10/) — Official source / 官方源
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/) — Practical guides / 实践指南
- [CWE (Common Weakness Enumeration)](https://cwe.mitre.org/) — Underlying weakness classification / 底层弱点分类

## Compatibility notes / 兼容性说明

- **No project dependency**: works in any codebase. / 无项目依赖。
- **No tool dependency**: the checklist is methodology; commands above are best-effort. / 无工具依赖：方法论；上面命令尽力而为。
- **Severity vocabulary unified** with `code-review-and-quality` (Critical / Required / Optional / Nit). / 严重程度词汇与 `code-review-and-quality` 统一。