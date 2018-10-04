import Foundation
import ApprovalTests_Swift

class TestReporter: ApprovalFailureReporter {
    public var received: String = ""
    public var approved: String = ""

    func report(received: String, approved: String) {
        self.received = received
        self.approved = approved
    }
}
