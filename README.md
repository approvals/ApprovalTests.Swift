[![Swift](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/swift.yml/badge.svg)](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/swift.yml)

# ApprovalTests

Capturing Human Intelligence — ApprovalTests is an open source assertion/verification library to aid unit testing.

ApprovalsTest Swift is compatible with the XCTest testing framework.

<!-- toc -->
## Contents

  * [Getting started](#getting-started)
  * [What can it be used for?](#what-can-it-be-used-for)
  * [Video Tutorials](#video-tutorials)
  * [Documentation](#documentation)
  * [Podcasts](#podcasts)
  * [How to get it](#how-to-get-it)
    * [Swift Package Manager](#swift-package-manager)
    * [Carthage](#carthage)
  * [Examples](#examples)
  * [Approved File Artifacts](#approved-file-artifacts)
  * [Questions?](#questions)<!-- endToc -->


## Getting started

Clone the [macOS starter project](https://github.com/approvals/ApprovalTests.Swift.StarterProject.MacOs)


## What can it be used for?

Approval Tests can be used for verifying objects that require more than a simple assert.


## Video Tutorials

You can watch a bunch of short videos on getting started and [using ApprovalTests in .Net](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368) at YouTube


## Documentation

[Find the documentation here](./docs/README.md)


## Podcasts

If you prefer auditory learning, you might enjoy the following podcasts:

- [This Agile Life](http://www.thisagilelife.com/46/)
- [Hanselminutes](http://www.hanselminutes.com/360/approval-tests-with-llewellyn-falco)
- [Herding Code](http://www.developerfusion.com/media/122649/herding-code-117-llewellyn-falcon-on-approval-tests/)
- [The Watir Podcast](http://watirpodcast.com/podcast-53/)


## How to get it

### Swift Package Manager

See an example [package manifest](https://github.com/approvals/ApprovalTests.Swift.StarterProject.MacOs/blob/main/Package.swift#L17-L22) here

Get the following dependency

<!-- snippet: package_include_approvals -->
<a id='snippet-package_include_approvals'></a>
```swift
dependencies: [
    .package(
        name: "ApprovalTests.Swift",
        url: "https://github.com/approvals/ApprovalTests.Swift",
        .branch("master")
        ),
],
```
<sup><a href='#snippet-package_include_approvals' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

And then add it to your test target

<!-- snippet: package_add_test_target -->
<a id='snippet-package_add_test_target'></a>
```swift
.testTarget(
        name: "ApprovalTests.Swift.StarterProject.MacOSTests",
        dependencies: [
            "ApprovalTests.Swift.StarterProject.MacOS",
            "ApprovalTests.Swift"
        ],
```
<sup><a href='#snippet-package_add_test_target' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### Carthage

Add the following to your Cartfile:

    github "approvals/ApprovalTests.Swift" "HEAD"

Then drag the the built framework from the appropriate Carthage/Build directory into your project,
but with "Copy items into destination group's folder" disabled.


## Examples

snippet: sample_test

will produce a file `SampleTest.testList.received.txt`:

    [0] = Dan
    [1] = James
    [2] = Jason
    [3] = Katrina
    [4] = Llewellyn

Simply rename this to SampleTest.testList.approved.txt, and the test will now pass.


## Approved File Artifacts

The `*.approved.*` files must be checked into source your source control. ApprovalTests now ignores line endings by default (so you can remove `*.approved.* binary` from your .gitattributes file if you added previously).

If you would like to verify line endings, simply add `[assembly: IgnoreLineEndingsAttribute(false)]` to your AssemblyInfo.cs

Do not add `*.received.*` files to your source control (they are transitory, and some SCMs like TFS will lock them or mark them read-only, which will break every dependent test).


## Questions?

Ask on Twitter: [@LlewellynFalco](https://twitter.com/#!/llewellynfalco) or #ApprovalTests
