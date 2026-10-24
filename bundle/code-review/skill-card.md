## Description:

Multi-dimensional code review with quality gates for evaluating changes across correctness, readability, architecture, security, and performance before merge.

This skill is ready for commercial/non-commercial use.

## Publisher:

[carolz1](https://clawhub.ai/user/carolz1)

### License/Terms of Use:

MIT

## Use Case:

Developers and engineering agents use this skill to review pull requests, diffs, refactors, bug fixes, and AI-generated code before merge. It produces structured findings with severity labels and an approve or request-changes verdict.

### Deployment Geography for Use:

Global

## Known Risks and Mitigations:

Risk: The skill may suggest optional Bash commands for audits and profiling.

Mitigation: Review commands before execution and pin npx package versions when using performance checklist tooling.

Risk: Review output can include incorrect or misleading guidance if applied without project context.

Mitigation: Treat findings as review assistance, verify them against the codebase, and scan the skill before deployment.

## Reference(s):

- [ClawHub skill page](https://clawhub.ai/carolz1/skills/code-review)
- [Source repository](https://github.com/CarolZ1/code-review)
- [Server-resolved provenance commit](https://github.com/CarolZ1/code-review/tree/361814f01f1f2c1a6d9b1ef757e4390dbb460ada)
- [Security Review Checklist](references/security-checklist.md)
- [Performance Review Checklist](references/performance-checklist.md)

## Skill Output:

**Output Type(s):** [markdown, guidance, shell commands]

**Output Format:** [Markdown review report with checklists, severity-labeled findings, and optional inline shell commands for audits or profiling]

**Output Parameters:** [1D]

**Other Properties Related to Output:** [Bilingual English and Chinese guidance; no executable payload in the skill artifact.]

## Skill Version(s):

0.1.0 (source: server release metadata; artifact frontmatter says 1.0.0)

## Ethical Considerations:

Users should evaluate whether this skill is appropriate for their environment, review any generated or modified files before relying on them, and apply their organization's safety, security, and compliance requirements before deployment.
