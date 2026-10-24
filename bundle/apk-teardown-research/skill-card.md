## Description:

Analyzes Android APKs or public file URLs through the Crawlora API to inspect static-analysis results, compare versions, build timelines, and compare ownership signals, returning JSON.

This skill is ready for commercial/non-commercial use.

## Publisher:

[crawlora-org](https://clawhub.ai/user/crawlora-org)

### License/Terms of Use:

MIT-0

## Use Case:

Mobile security researchers and developers use this skill to inspect authorized Android packages for permissions, signing, SDKs, and release changes, and to compare ownership signals.

### Deployment Geography for Use:

Global

## Known Risks and Mitigations:

Risk: Submitting APKs or public file URLs sends package data and the API key to Crawlora for analysis.

Mitigation: Submit only packages you are authorized to share and inspect; keep the API key private.

Risk: Deleting a job can remove retained job metadata and results without a confirmation prompt.

Mitigation: Require explicit approval and verify the job ID before invoking DELETE.

## Reference(s):

- [APK teardown endpoint reference](artifact/reference/endpoints.md)
- [Crawlora](https://crawlora.net)

## Skill Output:

**Output Type(s):** [Text, Guidance]

**Output Format:** [JSON results with concise explanatory text]

**Output Parameters:** [1D]

**Other Properties Related to Output:** [Requires a Crawlora API key and authorized APK or public HTTPS file URL.]

## Skill Version(s):

1.0.11 (source: ClawHub release evidence)

## Ethical Considerations:

Users should evaluate whether this skill is appropriate for their environment, review any generated or modified files before relying on them, and apply their organization's safety, security, and compliance requirements before deployment.
