UPCOMING RELEASE
----------------

**Breaking Changes:**

- Stop reporting the object type.

**Fixes:**

- Was broken for Xcode 13.3 changes in the call stack. Now fixed.
- Skip reporters that can't handle the file type. So if you have an image artifact, Approvals.Swift will use the first reporter that can show image differences.
- Fix iOS results watcher to support project paths with spaces.

**Features:**

- `verifyAll` improvements:
  - Now has an optional `header` to print above the array.
  - A new `verifyAll` takes a `labeler` closure to format each line. Use `{ $0 }` when you don't care about absolute indices, only relative order. This also provides a simple way to do parameterized tests: verify an array of inputs, and use the closure to print both the input and the output.
- For iOS tests, print reminder to console to turn on the watcher.
- SimpleLogger
- New verify:
  * UIKitApprovals.verify for verifying UIViews and rendered UIViewControllers.
  * Verifiable
- New reporters:
  * ReportMoveCommandToConsole
  * Make ReportByOpeningReceivedFile available on iOS, not just macOS


Version 1.0.0
-------------
_16 Jan 2022_

- Initial release
