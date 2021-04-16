import Foundation

class Options {
    public init() {}

    public func getReporter() -> ApprovalFailureReporter {
        return Approvals.getReporter()
    }
}
