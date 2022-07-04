/**
 A composite reporter that goes through a list of reporters, running the first one that is available on the current machine.
 */
public class FirstWorkingReporter: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]

    public init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    public override func report(received: String,
                                approved: String,
                                file: StaticString = #filePath,
                                line: UInt = #line) -> Bool {
        for reporter in reporters {
            if reporter.report(received: received, approved: approved, file: file, line: line) {
                return true
            }
        }
        return false
    }

    override public func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? FirstWorkingReporter else { return false }
        return reporters == other.reporters
    }
}
