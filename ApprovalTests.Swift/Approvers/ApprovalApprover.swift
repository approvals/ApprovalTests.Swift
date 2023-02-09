public protocol ApprovalApprover {
    func approve() -> Bool
    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter)
    func fail(file: StaticString, function: StaticString, line: UInt) throws
    func reportFailure(reporter: ApprovalFailureReporter, file: StaticString, function: StaticString, line: UInt)
}
