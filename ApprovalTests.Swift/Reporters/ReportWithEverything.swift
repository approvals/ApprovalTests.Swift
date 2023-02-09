/**
 A composite reporter that goes through a list of reporters, running all that are available on the current machine.
 */
public class ReportWithEverything: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]

    public init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    override public func report(received: String,
                                approved: String,
                                file: StaticString = #filePath,
                                function: StaticString = #function,
                                line: UInt = #line) -> Bool
    {
        var worked = false
        for reporter in reporters {
            worked = reporter.report(received: received, approved: approved, file: file, function: function, line: line)
                || worked
        }
        return worked
    }

    override public func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? ReportWithEverything else { return false }
        return reporters == other.reporters
    }
}
