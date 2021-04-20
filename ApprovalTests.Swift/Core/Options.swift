public class Options {
    private let reporter: ApprovalFailureReporter?
    private let scrubber: Scrubber?

    public init() {
        reporter = nil
        scrubber = nil
    }

    public init(reporter: ApprovalFailureReporter) {
        self.reporter = reporter
        scrubber = nil
    }
    
    public init(_ scrubber: Scrubber) {
        reporter = nil
        self.scrubber = scrubber
    }

    public func getReporter() -> ApprovalFailureReporter {
        reporter ?? Approvals.getReporter()
    }

    public func getScrubber() -> Scrubber {
        scrubber ?? ScrubNothing()
    }

    public func withReporter(_ reporter: ApprovalFailureReporter) -> Options {
        Options(reporter: reporter)
    }

    func scrub(_ input: String) throws -> String {
        return getScrubber().scrub(input)
    }
}
