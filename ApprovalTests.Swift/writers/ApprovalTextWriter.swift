import Foundation

class ApprovalTextWriter: ApprovalWriter {
    var text = String()
    var fileExtensionWithoutDot = String()

    init(_ textIn: String, _ fileExtensionWithoutDotIn: String) {
        text = textIn
        fileExtensionWithoutDot = fileExtensionWithoutDotIn
    }

    func getApprovalFilename(base: String) -> String {
        let approvalFilename = String(base + ".approved" + "." + fileExtensionWithoutDot)
        return approvalFilename
    }

    func getReceivedFilename(base: String) -> String {
        let receivedFilename = String(base + ".received" + "." + fileExtensionWithoutDot)
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
