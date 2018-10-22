ApprovalTests
====

Capturing Human Intelligence - ApprovalTests is an open source assertion/verification library to aid unit testing.

ApprovalsTest Swift is compatible with the XCUnit testing framework

What can it be used for?
---

Approval Tests can be used for verifying objects that require more than a simple assert.

[Video Tutorials](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368)
---

You can watch a bunch of short videos on getting started and [using ApprovalTests in .Net](http://www.youtube.com/playlist?list=PL0C32F89E8BBB5368) at YouTube

Podcasts
---
If you prefer auditory learning, you might enjoy the following podcast 

- [This Agile Life](http://www.thisagilelife.com/46/)
- [Hanselminutes](http://www.hanselminutes.com/360/approval-tests-with-llewellyn-falco)
- [Herding Code](http://www.developerfusion.com/media/122649/herding-code-117-llewellyn-falcon-on-approval-tests/)
- [The Watir Podcast](http://watirpodcast.com/podcast-53/)

How to get it
---
Coacoa Pods
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

    SampleTest.TestList.received.txt
    [0] = Dan
    [1] = James
    [2] = Jason
    [3] = Katrina
    [4] = Llewellyn

Simply rename this to SampleTest.testList.approved.txt and the test will now pass.


Approved File Artifacts
---

The `*.approved.*` files must be checked into source your source control. ApprovalTests now ignores line endings by default (so you can remove `*.approved.* binary` from your .gitattributes file if you added previously).

If you would like to verify line endings, simply add `[assembly: IgnoreLineEndingsAttribute(false)]` to your AssemblyInfo.cs

Do not add `*.received.*` files to your source control (they are transitory, and some SCMs like TFS will lock them or mark them read-only, which will break every dependent test).



More Info
---

- [Website](http://approvaltests.sourceforge.net/)
- [Blog](http://blog.approvaltests.com/)
- [Getting Started Doc](https://github.com/approvals/ApprovalTests.Net/blob/master/build/Documentation/Approval%20Tests%20-%20Getting%20Started.pdf?raw=true)

	
## LICENSE
[Apache 2.0 License](https://github.com/SignalR/SignalR/blob/master/LICENSE.md)


Questions?
---

ask on twitter: [@LlewellynFalco](https://twitter.com/#!/llewellynfalco) or #ApprovalTests
