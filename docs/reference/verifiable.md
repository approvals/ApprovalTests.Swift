# Verifiable

<!-- toc -->
## Contents

  * [Why](#why)
  * [How](#how)<!-- endToc -->


## Why

Verifiable allows you to make objects that are ApprovalTests-aware.

## How

If `verify()` is called with an instance of `Verifiable` it will do a callback allowing you to set up things like output and file types, etc. For example:

<!-- snippet: verifiable-example -->
<a id='snippet-verifiable-example'></a>
```swift
final class VerifiableTests: XCTestCase {
    func test_verifiable() throws {
        try Approvals.verify(SampleMarkdown())
    }
}

class SampleMarkdown: Verifiable, CustomStringConvertible {
    func getVerifyParameters(_ options: Options) -> VerifyParameters {
        VerifyParameters(options.forFile.with(extensionWithDot: ".md"))
    }

    public var description: String {
        """
        | A | B |
        |---|---|
        | 1 | 2 |
        """
    }
}
```
<sup><a href='/ApprovalTests_SwiftTests/VerifiableTests.swift#L8-L28' title='Snippet source file'>snippet source</a> | <a href='#snippet-verifiable-example' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

will produce the following markdown:

<!-- include: VerifiableTests.test_verifiable.approved.md -->
| A | B |
|---|---|
| 1 | 2 |
<!-- endInclude -->
