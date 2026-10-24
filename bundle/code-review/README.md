# Code Review / 代码审查与质量

> Multi-dimensional code review skill for AI agents — five axes, severity labels, and an approval standard. / 面向 AI 智能体的多维代码审查技能——五维审查、严重程度标签、明确的通过标准。

**English** | [中文说明](#中文说明)

## What it is

An AI agent skill that enforces disciplined, multi-dimensional review of **every change before merge**. No change ships unreviewed. It evaluates code across five axes — correctness, readability, architecture, security, and performance — and outputs a structured review report with severity-labeled findings so authors know exactly what blocks the merge and what is optional.

## Key features

- **Five-axis review / 五维审查** — correctness, readability & simplicity, architecture, security, performance
- **Severity labels / 严重程度标签** — `Critical` / `Required` / `Optional` / `Nit` / `FYI`, so blocking issues never hide behind cosmetic nits
- **Approval standard / 通过标准** — approve when the change definitively improves overall code health, even if imperfect
- **Change sizing / 变更规模** — guidance on reviewable change sizes (~100 / ~300 / ~1000 lines) and four splitting strategies (stack, by file group, horizontal, vertical)
- **Structural remedies / 结构修复** — every structural problem comes with a named refactoring move, not just a complaint
- **Reference checklists / 深度检查表** — OWASP Top 10 security checklist and a deep performance checklist (N+1 queries, network waterfalls, memory, frontend, caching, concurrency)
- **Anti-rationalization table / 反借口表** — calls out "it works, that's good enough", "AI-generated code is probably fine", and other classic review-evading excuses

## How it works

Review runs in five steps: understand context → review tests first → review implementation → categorize findings by severity → verify the author's verification story. Output follows a fixed report template ending in an **Approve** / **Request changes** verdict.

Works with any diff source: git diff, GitHub PR, GitLab MR, or pasted code. No tool dependencies.

## Usage

Drop the folder into your agent's skills directory. The agent triggers on phrases like "review this", "code review", "审查代码", "审查这个 PR".

## Repository structure

```
├── SKILL.md                            # Main skill instructions / 主指令
└── references/
    ├── security-checklist.md           # OWASP Top 10 checklist / 安全检查表
    └── performance-checklist.md         # Performance deep dive / 性能检查表
```

## License

MIT

---

# 中文说明

## 这是什么

一个 AI 智能体技能：**合并前对任何变更做多维度审查，没有例外**。从正确性、可读性、架构、安全、性能五个维度评估代码，输出带严重程度标签的结构化审查报告，让作者清楚知道哪些是阻塞项、哪些可选。

## 核心特性

- **五维审查**：正确性、可读性与简洁性、架构、安全、性能
- **严重程度标签**：`严重` / `必改` / `建议` / `细节` / `备忘`，真问题不会被格式细节淹没
- **通过标准**：变更确实提升整体代码健康度即通过，不追求完美
- **变更规模**：~100 行好审、~300 行可接受、~1000 行必须拆分，附四种拆分策略
- **结构修复**：每个结构问题都配一个命名重构动作，不只是指出问题
- **参考检查表**：OWASP Top 10 安全检查表 + 性能深入检查表（N+1 查询、网络瀑布流、内存、前端、缓存、并发）
- **反借口表**：戳破「能跑就行」「AI 生成的应该没问题」等经典合理化借口

## 使用方式

将文件夹放入智能体的 skills 目录即可。用户说 "review this"、"code review"、"审查代码"、"审查这个 PR" 时自动触发。

## 许可

MIT
