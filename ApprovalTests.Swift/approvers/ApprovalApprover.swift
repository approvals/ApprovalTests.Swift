protocol ApprovalApprover {
    func approve() -> Bool
    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter)
    func fail() throws
    func reportFailure(reporter: ApprovalFailureReporter)
}
