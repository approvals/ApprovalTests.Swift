public protocol ApprovalWriter {
    func approvalFilename(_ base: String) -> String
    func receivedFilename(_ base: String) -> String
    func writeReceivedFile(_ received: String)
}
