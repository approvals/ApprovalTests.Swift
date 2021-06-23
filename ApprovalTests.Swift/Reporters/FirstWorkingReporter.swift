public class FirstWorkingReporter: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]
public init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    public override func report(received: String, approved: String) -> Bool {
        for reporter in reporters {
            if reporter.report(received: received, approved: approved) {
                return true
            }
        }
        return false
    }

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? FirstWorkingReporter else { return false }
        return reporters == other.reporters
    }
}
