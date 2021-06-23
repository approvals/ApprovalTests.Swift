# Reporters

<!-- toc -->
## Contents

  * [Supported Diff Tools](#supported-diff-tools)
    * [Mac](#mac)
    * [iOS](#ios)<!-- endToc -->

## Supported Diff Tools

The `ReportWithDiffTool` goes to a chain of possible reporters to find the first option installed on your system.
Currently, the search goes in this order:

### Mac

<!-- snippet: mac_reporters -->
<a id='snippet-mac_reporters'></a>
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
<sup><a href='/ApprovalTests.Swift/Reporters/macOS/ReportersForMac.swift#L5-L15' title='Snippet source file'>snippet source</a> | <a href='#snippet-mac_reporters' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### iOS

<!-- snippet: ios_reporters -->
<a id='snippet-ios_reporters'></a>
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
<sup><a href='/ApprovalTests.Swift/Reporters/iOS/ReportersForiOS.swift#L5-L15' title='Snippet source file'>snippet source</a> | <a href='#snippet-ios_reporters' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

---

[Back to README](../README.md)
