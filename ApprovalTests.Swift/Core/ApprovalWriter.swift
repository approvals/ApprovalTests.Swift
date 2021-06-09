protocol ApprovalWriter {
    func approvalFilename(base: String) -> String
    func receivedFilename(base: String) -> String
    func writeReceivedFile(_ received: String)
}
