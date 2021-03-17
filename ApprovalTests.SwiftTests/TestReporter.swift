import Foundation
#if os(OSX)
@testable import ApprovalTests_Swift
#elseif os(iOS)
@testable import ApprovalTests_iOS
#endif

class TestReporter: ApprovalFailureReporter {
    private let success: Bool

    init(success: Bool) {
        self.success = success
    }

    func report(received: String, approved: String) -> Bool {
        self.received = received
        self.approved = approved
        return success
    }

    public var received: String = ""
    public var approved: String = ""
}
