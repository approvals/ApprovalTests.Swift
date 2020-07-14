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
        print("Received=\(received)")
        print("FileURL=\(fileUrl)|")
        print("FileURL PTH=\(fileUrl.path)|")
        do {
            
            //try text.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
            let fileName = fileUrl.lastPathComponent
            print("filename=\(fileName)")
 
            let fileUrl2 = URL(fileURLWithPath: "/Users/nicolas/Downloads/approvals/approvalsTests/Demo/testFile.txt")
            try text.write(toFile: fileUrl2.path, atomically: true, encoding: .utf8)
            
            
        } catch {
            print("An error occured writing file:" + received)
            print("ERROR=\(error)")
        }

        return fileUrl.path
    }

    
}
