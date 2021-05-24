class ReportWithEverything: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]

    init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    override func report(received: String, approved: String) -> Bool {
        var worked = false
        for reporter in reporters {
            worked = reporter.report(received: received, approved: approved) || worked
        }
        return worked
    }

    override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? ReportWithEverything else { return false }
        return reporters == other.reporters
    }
}
