UPCOMING RELEASE
----------------

**Fixes:**

- Was broken for Xcode 13.3 changes in the call stack. Now fixed.

**Features:**

- `verifyAll` improvements:
  - Now has an optional `header` to print above the array.
  - A new `verifyAll` takes a `labeler` closure to format each line. Use `{ $0 }` when you don't care about absolute indices, only relative order. This also provides a simple way to do parameterized tests: verify an array of inputs, and use the closure to print both the input and the output.
- Skip reporters that can't handle the file type. So if you have an image artifact, Approvals.Swift will use the first reporter that can show image differences.
- Print reminder to console output to turn on the watcher for iOS tests.


Version 1.0.0
-------------
_16 Jan 2022_

- Initial release
