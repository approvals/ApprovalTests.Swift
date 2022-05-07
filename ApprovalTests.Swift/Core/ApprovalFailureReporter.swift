public protocol ApprovalFailureReporter {
    func report(received: String, approved: String) -> Bool
}

public class EquatableFailureReporter: ApprovalFailureReporter, Equatable {
    public func report(received _: String, approved _: String) -> Bool {
        false
    }

    public func isEqualTo(_: ApprovalFailureReporter) -> Bool {
        false
    }

    public static func == (lhs: EquatableFailureReporter, rhs: EquatableFailureReporter) -> Bool {
        lhs.isEqualTo(rhs)
    }
}
