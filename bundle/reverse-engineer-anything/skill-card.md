## Description:

Helps agents inspect authorized Android apps and other software without source code using containerized reverse-engineering tools.

This skill is ready for commercial/non-commercial use.

## Publisher:

[psyb0t](https://clawhub.ai/user/psyb0t)

### License/Terms of Use:

MIT-0

## Use Case:

Developers and security analysts use this skill to inspect authorized APKs, binaries, resources, and network captures, then trace where software behavior is implemented.

### Deployment Geography for Use:

Global

## Known Risks and Mitigations:

Risk: The default container image uses a mutable tag.

Mitigation: Pin REA_IMAGE to a reviewed image digest before running it.

Risk: Broad mounts or optional network access may expose unrelated files or services.

Mitigation: Mount only the target directory read-only and enable network access only when necessary.

Risk: A running MCP service may remain reachable after analysis.

Mitigation: Keep the service local, protect its bearer token, and stop the detached container when finished.

## Reference(s):

- [ClawHub skill release](https://clawhub.ai/psyb0t/skills/reverse-engineer-anything)
- [Setup and usage guidance](artifact/references/setup.md)

## Skill Output:

**Output Type(s):** [Text, Markdown, Shell commands, Configuration guidance]

**Output Format:** [Markdown guidance and command examples; analysis tools return JSON]

**Output Parameters:** [1D]

**Other Properties Related to Output:** [Static analysis cannot establish runtime behavior.]

## Skill Version(s):

0.1.1 (source: ClawHub release metadata)

## Ethical Considerations:

Users should evaluate whether this skill is appropriate for their environment, review any generated or modified files before relying on them, and apply their organization's safety, security, and compliance requirements before deployment.
