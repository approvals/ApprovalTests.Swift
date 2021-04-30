protocol ApprovalWriter {
    func writeReceivedFile(_ received: String) -> String
    func getReceivedFilename(base: String) -> String
    func getApprovalFilename(base: String) -> String
}
