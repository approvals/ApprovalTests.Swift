# Reporters

<!-- toc -->
## Contents

  * [Supported Diff Tools](#supported-diff-tools)<!-- endToc -->

## Supported Diff Tools

`ReportWithDiffTool` is a chain of possible reporters to find the first diff tool installed on your system.
Currently, the search goes in this order:

<!-- snippet: reporters -->
<a id='snippet-reporters'></a>
```swift
ReportWithBeyondCompare(),
ReportWithAppCode(),
ReportWithDiffMerge(),
ReportWithKaleidoscope(),
ReportWithP4Merge(),
ReportWithKdiff3(),
ReportWithTKDiff(),
ReportWithVisualStudioCode(),
ReportContentsWithXCTest()
```
<sup><a href='/ApprovalTests.Swift/Reporters/ReportWithDiffTool.swift#L4-L14' title='Snippet source file'>snippet source</a> | <a href='#snippet-reporters' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

---

[Back to README](../README.md)
