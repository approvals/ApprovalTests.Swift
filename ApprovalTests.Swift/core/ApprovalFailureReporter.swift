import Foundation

public protocol ApprovalFailureReporter {
    func report(received: String, approved: String) -> Bool
}

open class EquatableFailureReporter: ApprovalFailureReporter, Equatable {
    public func report(received: String, approved: String) -> Bool {
        false
    }

    func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        false
    }

    public static func ==(lhs: EquatableFailureReporter, rhs: EquatableFailureReporter) -> Bool {
        lhs.isEqualTo(rhs)
    }
}
