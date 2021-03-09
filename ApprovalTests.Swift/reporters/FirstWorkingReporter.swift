import Foundation

class FirstWorkingReporter: ApprovalFailureReporter {
    private let reporters: [ApprovalFailureReporter]

    public init(_ reporters: ApprovalFailureReporter...) {
        self.reporters = reporters
    }

    func report(received: String, approved: String) -> Bool {
        for reporter in reporters {
            if reporter.report(received: received, approved: approved) {
                return true
            }
        }
        return false
    }
}
