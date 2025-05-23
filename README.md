# <img src="https://avatars3.githubusercontent.com/u/36907" height="30px"> ApprovalTests

[![Build Status](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/build.yml/badge.svg)](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/build.yml)
[![Swift Package Index Swift Version Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fapprovals%2FApprovalTests.Swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/approvals/ApprovalTests.Swift)
[![Swift Package Index Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fapprovals%2FApprovalTests.Swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/approvals/ApprovalTests.Swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/ApprovalTests_Swift/badge.png)](https://cocoapods.org/pods/ApprovalTests_Swift)

Approval Tests are an alternative to assertions. You’ll find them useful for testing objects with complex values (such as long strings), lots of properties, or collections of objects.

ApprovalTests.Swift is compatible with the XCTest testing framework.

<!-- toc -->
## Contents

  * [My First Approval Test](#my-first-approval-test)
  * [Getting Started](#getting-started)
  * [Predefined Verifiers](#predefined-verifiers)
  * [How to Use with iOS](#how-to-use-with-ios)
  * [Which File Artifacts to Exclude from Source Control](#which-file-artifacts-to-exclude-from-source-control)
  * [Other Ways to Get It](#other-ways-to-get-it)
    * [Swift Package Manager](#swift-package-manager)
    * [Carthage](#carthage)
    * [CocoaPods](#cocoapods)
  * [For More Information](#for-more-information)
    * [Questions?](#questions)
    * [Documentation](#documentation)
    * [Video Tutorials](#video-tutorials)
    * [Podcasts](#podcasts)<!-- endToc -->


## My First Approval Test

We'll start by writing a simple unit test to verify a list of names. But instead of using XCTest's `XCTAssertEqual` function, we'll use `Approvals.verifyAll`:

<!-- snippet: sample_test -->
<a id='snippet-sample_test'></a>
```swift
class SampleArrayTests: XCTestCase {
    func testList() throws {
        var names = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll(names, label: "")
    }
```
<sup><a href='/ApprovalTests_SwiftTests/Demo/SampleArrayTests.swift#L8-L15' title='Snippet source file'>snippet source</a> | <a href='#snippet-sample_test' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

The `verifyAll()` function performs a test assertion for a list of items. Unlike a normal assertion, it doesn’t specify an expected list. Instead, this will produce a “received” file matching the name of your test suite and test case. In this example, it will write a file `SampleArrayTests.testList.received.txt`:

<!-- snippet: SampleArrayTests.testList.approved.txt -->
<a id='snippet-SampleArrayTests.testList.approved.txt'></a>
```txt
[0] = Dan
[1] = James
[2] = Jason
[3] = Katrina
[4] = Llewellyn
```
<sup><a href='/ApprovalTests_SwiftTests/Demo/SampleArrayTests.testList.approved.txt#L1-L5' title='Snippet source file'>snippet source</a> | <a href='#snippet-SampleArrayTests.testList.approved.txt' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

It also opens two files in a diff editor—the “received” file, and the “approved” file.

![Results shown in diff editor](FirstTestResult.png)

To approve the results, tell the diff editor to apply changes from the left side to the right side:

![Results copied from received to approved](FirstTestApproved.png)

Most of the time, you’ll use one of the [supported diff tools](docs/reference/reporters.md#supported-diff-tools) to examine and approve the result. If you don’t have any of these diff tools, you can rename the received file to `SampleArrayTests.testList.approved.txt` and the test will now pass.


## Getting Started

The best way to get started is download and open one of the starter projects:
* [macOS](https://github.com/approvals/ApprovalTests.Swift.StarterProject.MacOs)
* [iOS](https://github.com/approvals/ApprovalTests.Swift.StarterProject.IOs)

These are standard projects and can be imported into any editor or IDE.  
They also all have CI with Github actions.

They come ready with:

- A Swift package definition adding ApprovalTests.Swift to the test target
- A suitable `.gitignore` to exclude approval artifacts
- A GitHub action to build and run tests
- A GitHub build status badge


## Predefined Verifiers

ApprovalTests.Swift comes with useful verifiers:

- `Approvals.verify` — verify object or dictionary
- `Approvals.verifyAll` — verify array of items (or use array as inputs)
- `Approvals.verifyAsJSON` — verify Encodable object converted to JSON
- `Approvals.verifyQuery` — verify query, also showing query results on failure
- `Approvals.verifySequence` — verify sequence of changing values


## How to Use with iOS

ApprovalTests.Swift runs out-of-the-box for macOS tests. But for iOS tests, you need a separate process running on your Mac to watch for diffs. Run [iOSApprovalsWatcher.py](https://github.com/approvals/ApprovalTests.Swift/blob/master/iOSApprovalsWatcher.py) from your command line, giving it the path to your test directory.


## Which File Artifacts to Exclude from Source Control

You must add any “approved” files to your source control system. But “received” files can change with any run and should be ignored. For Git, add this to your `.gitignore`:

```
*.received.*
```

If you have iOS tests, you should also add `command.sh` to your `.gitignore`. (They are scripts written by the iOS side for the file monitor to execute from the macOS side.) So for iOS testing, make sure to exclude:

```
*.received.*
command.sh
```


## Other Ways to Get It

### Swift Package Manager

See an example [package manifest](https://github.com/approvals/ApprovalTests.Swift.StarterProject.MacOs/blob/main/Package.swift#L17-L22) here

Get the following dependency:

<!-- snippet: package_include_approvals -->
<a id='snippet-package_include_approvals'></a>
```swift
dependencies: [
    .package(
        url: "https://github.com/approvals/ApprovalTests.Swift",
        branch: "master"
    ),
],
```
<sup><a href='#snippet-package_include_approvals' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

Then add it to your test target:

<!-- snippet: package_add_test_target -->
<a id='snippet-package_add_test_target'></a>
```swift
.testTarget(
    name: "ApprovalTests.Swift.StarterProject.MacOSTests",
    dependencies: [
        "ApprovalTests.Swift.StarterProject.MacOS",
        "ApprovalTests.Swift",
    ],
```
<sup><a href='#snippet-package_add_test_target' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### Carthage

Add the following to your Cartfile:

    github "approvals/ApprovalTests.Swift" ~> 2.0

Then drag the the built framework from the appropriate Carthage/Build directory into your project,
but with “Copy items into destination group’s folder” disabled.

### CocoaPods

If you want to add ApprovalTests.Swift using Cocoapods then add the following dependency to your Podfile.
Most people will want ApprovalTests.Swift in their test targets, and not include any pods from their main
targets:

```ruby
target 'MyTests' do
  inherit! :search_paths
  use_frameworks!
  pod 'ApprovalTests_Swift', '~> 2.0'
end
```

## For More Information

### Questions?

Ask Llewellyn Falco [@LlewellynFalco](https://twitter.com/llewellynfalco) on Twitter, or Jon Reid on [BlueSky](https://bsky.app/profile/qcoding.bsky.social) or [Mastodon](https://iosdev.space/@qcoding).

### Documentation

[Find some extra documentation here](./docs/README.md).

### Video Tutorials

- [Getting Started with ApprovalTests.Swift](https://qualitycoding.org/approvaltests-swift-getting-started/)
- [How to Verify Objects (and Simplify TDD)](https://qualitycoding.org/approvaltests-swift-verify-objects/)
- [Verify Arrays and See Simple, Clear Diffs](https://qualitycoding.org/verify-arrays-approvaltests-swift/)
- [Write Parameterized Tests by Transforming Sequences](https://qualitycoding.org/parameterized-tests-approvaltests-swift/)
- [Wrangle Legacy Code with Combination Approvals](https://qualitycoding.org/wrangle-legacy-code-combination-approvals/)

You can also watch a series of short videos about [using ApprovalTests in .Net](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368) on YouTube.

### Podcasts

Prefer learning by listening? Then you might enjoy the following podcasts:

- [This Agile Life](http://www.thisagilelife.com/46/)
- [Hanselminutes](http://www.hanselminutes.com/360/approval-tests-with-llewellyn-falco)
- [Herding Code](http://www.developerfusion.com/media/122649/herding-code-117-llewellyn-falcon-on-approval-tests/)
- [The Watir Podcast](http://watirpodcast.com/podcast-53/)
