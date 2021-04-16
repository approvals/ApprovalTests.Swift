protocol ApprovalWriter {
    func writeReceivedFile(received: String) -> String
    func getReceivedFilename(base: String) -> String
    func getApprovalFilename(base: String) -> String
}
