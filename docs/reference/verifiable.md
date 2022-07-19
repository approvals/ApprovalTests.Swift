# Verifiable

<!-- toc -->
## Contents

* [Supported Diff Tools](#supported-diff-tools)<!-- endToc -->


## Why

Verifiable allows you to make objects that are ApprovalTests-aware.

## How

If `verify()` is called with an instance of `Verifiable` it will do a callback allowing you to set up things like output and file types, etc. For example:

snippet: verifiable-example

will produce the following markdown:

include: VerifiableTests.test_verifiable.approved.md
