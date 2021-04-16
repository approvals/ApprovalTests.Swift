import Foundation

class Options {
    private let reporter: ApprovalFailureReporter?

    public init() {
        reporter = nil
    }

    public init(_ reporter: ApprovalFailureReporter) {
        self.reporter = reporter
    }

    public func getReporter() -> ApprovalFailureReporter {
        reporter ?? Approvals.getReporter()
    }

    public func withReporter(_ reporter: ApprovalFailureReporter) -> Options {
        Options(reporter)
    }
}
