import Foundation

public protocol ApprovalFailureReporter {
    func report(received: String, approved: String) -> Bool
}

open class EquatableFailureReporter: ApprovalFailureReporter, Equatable {
    public func report(received: String, approved: String) -> Bool {
        return false
    }

    func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        return false
    }

    public static func ==(lhs: EquatableFailureReporter, rhs: EquatableFailureReporter) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}
