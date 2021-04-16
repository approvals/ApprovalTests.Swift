import Foundation

class FirstWorkingReporter: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]

    public init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let otherReporter = other as? FirstWorkingReporter else { return false }
        return self.reporters == otherReporter.reporters
    }

    override func report(received: String, approved: String) -> Bool {
        for reporter in reporters {
            if reporter.report(received: received, approved: approved) {
                return true
            }
        }
        return false
    }
}
