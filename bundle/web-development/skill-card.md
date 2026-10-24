## Description:

Web helps agents build, debug, and deploy website projects using HTML, CSS, JavaScript, and common front-end frameworks.

This skill is ready for commercial/non-commercial use.

## Publisher:

[thcjp](https://clawhub.ai/user/thcjp)

### License/Terms of Use:

MIT-0

## Use Case:

Developers and web teams use this skill to generate front-end code, debug website behavior, and prepare deployment configuration or launch checklists for website projects.

### Deployment Geography for Use:

Global

## Known Risks and Mitigations:

Risk: Broad web-development assistance may write project files or propose commands that affect the working tree.

Mitigation: Use the skill only in the intended project directory, review file diffs and commands before execution, and rely on agent platform sandboxing or approval controls.

Risk: API keys or deployment credentials may be needed for build, API, or deployment workflows.

Mitigation: Keep credentials in environment variables or a secret manager, avoid hardcoding them in generated files, and exclude secrets from version control.

Risk: Generated web code may introduce client-side security defects or vulnerable dependencies.

Mitigation: Review generated code for XSS and access-control issues, run dependency scans, and test before deployment.

## Reference(s):

- [ClawHub skill page](https://clawhub.ai/thcjp/skills/web)

## Skill Output:

**Output Type(s):** [text, markdown, code, shell commands, configuration, guidance]

**Output Format:** [Markdown with code blocks, JSON examples, and shell commands]

**Output Parameters:** [1D]

**Other Properties Related to Output:** [May include project files, deployment checklists, debugging analysis, and security review guidance.]

## Skill Version(s):

1.0.1 (source: server release evidence and SKILL.md frontmatter)

## Ethical Considerations:

Users should evaluate whether this skill is appropriate for their environment, review any generated or modified files before relying on them, and apply their organization's safety, security, and compliance requirements before deployment.
