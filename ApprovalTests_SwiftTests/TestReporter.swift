#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
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
