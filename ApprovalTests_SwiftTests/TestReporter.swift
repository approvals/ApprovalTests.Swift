#if os(iOS)
  @testable import ApprovalTests_iOS
#else
  @testable import ApprovalTests_Swift
#endif

class TestReporter: EquatableFailureReporter {
  private(set) var received = ""
  private(set) var approved = ""
  private let success: Bool

  init(success: Bool) {
    self.success = success
  }

  override func report(received: String, approved: String, file: StaticString, line: UInt) -> Bool {
    self.received = received
    self.approved = approved
    return success
  }
}
