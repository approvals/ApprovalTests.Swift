import Foundation

public class UseReporterFromAnnotations: ApprovalFailureReporter {
    public init() {}
    public func report(received: String, approved: String) -> Bool {
        return ReporterFactory.get().report(received: received, approved: approved)
    }
}
