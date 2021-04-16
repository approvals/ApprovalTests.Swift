public protocol ApprovalFailureReporter {
    func report(received: String, approved: String) -> Bool
}

class EquatableFailureReporter: ApprovalFailureReporter, Equatable {
    func report(received: String, approved: String) -> Bool {
        false
    }

    func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        false
    }
    
    static func ==(lhs: EquatableFailureReporter, rhs: EquatableFailureReporter) -> Bool {
        lhs.isEqualTo(rhs)
    }
}
