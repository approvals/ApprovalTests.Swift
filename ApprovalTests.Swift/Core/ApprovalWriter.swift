protocol ApprovalWriter {
    func writeReceivedFile(_ received: String) -> String
    func receivedFilename(base: String) -> String
    func approvalFilename(base: String) -> String
}
