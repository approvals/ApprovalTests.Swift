#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif

class TestReporter: EquatableFailureReporter {
    public private(set) var received = ""
    public private(set) var approved = ""
    private let success: Bool

    init(success: Bool) {
        self.success = success
    }

    override func report(received: String, approved: String) -> Bool {
        self.received = received
        self.approved = approved
        return success
    }
}
