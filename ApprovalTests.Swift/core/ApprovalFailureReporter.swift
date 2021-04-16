import Foundation

public protocol ApprovalFailureReporter {
    func report(received: String, approved: String) -> Bool
}

class EquatableFailureReporter: ApprovalFailureReporter, Equatable {
    func report(received: String, approved: String) -> Bool {
        return false
    }

    func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        return false
    }
    
    static func ==(lhs: EquatableFailureReporter, rhs: EquatableFailureReporter) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}
