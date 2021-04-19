protocol ApprovalApprover {
    func approve() -> Bool
    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter)
    func fail(file: StaticString, line: UInt) throws
    func reportFailure(reporter: ApprovalFailureReporter)
}
