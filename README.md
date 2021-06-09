[![Swift](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/swift.yml/badge.svg)](https://github.com/approvals/ApprovalTests.Swift/actions/workflows/swift.yml)

# ApprovalTests

Capturing Human Intelligence - ApprovalTests is an open source assertion/verification library to aid unit testing.

ApprovalsTest Swift is compatible with the XCUnit testing framework

<!-- toc -->
## Contents

  * [Getting started](#getting-started)
  * [What can it be used for?](#what-can-it-be-used-for)
  * [Video Tutorials](#video-tutorials)
  * [Documentation](#documentation)
  * [Podcasts](#podcasts)
  * [How to get it](#how-to-get-it)
    * [Swift Package Manager](#swift-package-manager)
    * [CocoaPods](#cocoapods)
  * [Approved File Artifacts](#approved-file-artifacts)
  * [More Info](#more-info)
  * [LICENSE](#license)
  * [Questions?](#questions)<!-- endToc -->

## Getting started

Clone the [macOS starter project](https://github.com/approvals/ApprovalTests.Swift.StarterProject.MacOs)

## What can it be used for?

Approval Tests can be used for verifying objects that require more than a simple assert.

## [Video Tutorials](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368)

You can watch a bunch of short videos on getting started and [using ApprovalTests in .Net](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368) at YouTube

## Documentation

[Find the documentation here](./docs/README.md)

## Podcasts
If you prefer auditory learning, you might enjoy the following podcast 

- [This Agile Life](http://www.thisagilelife.com/46/)
- [Hanselminutes](http://www.hanselminutes.com/360/approval-tests-with-llewellyn-falco)
- [Herding Code](http://www.developerfusion.com/media/122649/herding-code-117-llewellyn-falcon-on-approval-tests/)
- [The Watir Podcast](http://watirpodcast.com/podcast-53/)

## How to get it
### Swift Package Manager

<!-- snippet: https://raw.githubusercontent.com/approvals/ApprovalTests.Swift.StarterProject.MacOs/main/Package.swift#package_include_approvals -->
<a id='snippet-https://raw.githubusercontent.com/approvals/ApprovalTests.Swift.StarterProject.MacOs/main/Package.swift'></a>
```swift
// swift-tools-version:5.2

import PackageDescription

let package = Package(
        name: "ApprovalTests.Swift.StarterProject.MacOS",
        platforms: [
            .macOS(.v10_14),
        ],
        products: [
            .library(
                    name: "ApprovalTests.Swift.StarterProject.MacOS",
                    targets: ["ApprovalTests.Swift.StarterProject.MacOS"]
            ),
        ],
        dependencies: [
            .package(
                url: "https://github.com/approvals/ApprovalTests.Swift.git",
                .branch("master")
                ),
        ],
        targets: [
            .target(
                    name: "ApprovalTests.Swift.StarterProject.MacOS",
                    dependencies: [],
                    path: "ApprovalTests.Swift.StarterProject.MacOS"
            ),
            .testTarget(
                    name: "ApprovalTests.Swift.StarterProject.MacOSTests",
                    dependencies: [
                        "ApprovalTests.Swift.StarterProject.MacOS",
                        "ApprovalTests.Swift"
                    ],
                    path: "ApprovalTests.Swift.StarterProject.MacOSTests"
            ),
        ]
)
```
<sup><a href='#snippet-https://raw.githubusercontent.com/approvals/ApprovalTests.Swift.StarterProject.MacOs/main/Package.swift' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### CocoaPods
```
target 'MyApp' do
  use_frameworks!

  # Pods for MyApp 

  target 'MyAppTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'ApprovalTests_Swift', :git => 'https://github.com/approvals/ApprovalTests.Swift.git'
  end

end

```

Examples
---
[Sample Code](https://github.com/approvals/ApprovalTests.Swift/blob/master/ApprovalTests.SwiftTests/Demo/SampleArrayTest.swift)
```Swift
class SampleTest: XCTestCase {

    	func testList() throws {
        	var names: [String] = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        	names.sort()
        	try Approvals.verifyAll("", names);
    	}
}
```
Will Produce a File

    SampleTest.testList.received.txt
    [0] = Dan
    [1] = James
    [2] = Jason
    [3] = Katrina
    [4] = Llewellyn

Simply rename this to SampleTest.testList.approved.txt and the test will now pass.


## Approved File Artifacts

The `*.approved.*` files must be checked into source your source control. ApprovalTests now ignores line endings by default (so you can remove `*.approved.* binary` from your .gitattributes file if you added previously).

If you would like to verify line endings, simply add `[assembly: IgnoreLineEndingsAttribute(false)]` to your AssemblyInfo.cs

Do not add `*.received.*` files to your source control (they are transitory, and some SCMs like TFS will lock them or mark them read-only, which will break every dependent test).



## More Info

- [Blog](http://blog.approvaltests.com/)

	
## LICENSE
[Apache 2.0 License](https://github.com/SignalR/SignalR/blob/master/LICENSE.md)


## Questions?

ask on twitter: [@LlewellynFalco](https://twitter.com/#!/llewellynfalco) or #ApprovalTests
