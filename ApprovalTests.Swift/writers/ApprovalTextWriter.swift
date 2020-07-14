import Foundation

class ApprovalTextWriter: ApprovalWriter {
    var text = String()
    var fileExtentionWithoutDot = String()

    init(_ textIn: String, _ fileExtentionWithoutDotIn: String) {
        text = textIn
        fileExtentionWithoutDot = fileExtentionWithoutDotIn
    }

    func getApprovalFilename(base: String) -> String {
        let approvalFilename = String(base + ".approved" + "." + fileExtentionWithoutDot)
        return approvalFilename
    }

    func getReceivedFilename(base: String) -> String {
        let receivedFilename = String(base + ".received" + "." + fileExtentionWithoutDot)
        return receivedFilename
    }

    func writeReceivedFile(received: String) -> String {
        let fileUrl = URL(fileURLWithPath: received)
        do {
            try text.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
        } catch {
            print("An error occured writing file:" + received)
            print("ERROR=\(error)")
        }

        return fileUrl.path
    }

    
}
