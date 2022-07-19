UPCOMING RELEASE
----------------

## Breaking Changes:

- Stop reporting the object type.
For example,
```swift
  try Approvals.verify("Hello world")
```
will produce these changes in your `.approved.` files
```diff
- CGRect: (5.0, 10.0, 100.0, 200.0)
+ (5.0, 10.0, 100.0, 200.0)
```

## Fixes:

- Works with Xcode 13.3. Changes in Xcode 13.3's call stack caused this issue.
- Skip reporters that can't handle the file type. So if you have an image artifact, Approvals.Swift will use the first reporter that can show image differences.
- Fix iOS results watcher to support project paths with spaces.

## Features:

- `verifyAll` improvements:
  - Now has an optional `header` to print above the array.
  - A new `verifyAll` takes a `labeler` closure to format each line.
For example, here's a way to make lists without indices:
```swift
  try Approvals.verifyAll(header: "grocery list", groceries) { $0 }
```
- For iOS tests, ApprovalTests will print a reminder to turn on the watcher.
- SimpleLogger: an easy way to log and do performance profiling.
- UIKitApprovals.verify for verifying UIViews and rendered UIViewControllers.
- New reporters:
  * ReportMoveCommandToConsole
  * Make ReportByOpeningReceivedFile available on iOS, not just macOS

### Verifiable

Approvals now offers a [Verifiable interface](docs/reference/verifiable.md) that understands approvals.

Version 1.0.0
-------------
_16 Jan 2022_

- Initial release
