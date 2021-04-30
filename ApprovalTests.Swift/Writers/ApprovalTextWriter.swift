import Foundation

class ApprovalTextWriter: ApprovalWriter {
    private let text: String
    private let fileExtensionWithoutDot: String

    init(_ text: String, _ fileExtensionWithoutDot: String) {
        if !text.hasSuffix("\n") {
            self.text = text + "\n"
        } else {
            self.text = text
        }
        self.fileExtensionWithoutDot = fileExtensionWithoutDot
    }

    func getApprovalFilename(base: String) -> String {
        let approvalFilename = "\(base).approved.\(fileExtensionWithoutDot)"
        return approvalFilename
    }

    func getReceivedFilename(base: String) -> String {
        let receivedFilename = "\(base).received.\(fileExtensionWithoutDot)"
        return receivedFilename
    }

    func writeReceivedFile(received: String) -> String {
        let fileUrl = URL(fileURLWithPath: received)
        do {
            try text.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
        } catch {
            print("An error occurred writing file:" + received)
            print("Error: \(error)")
        }

        return fileUrl.path
    }

}
