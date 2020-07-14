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
        print("FileURL=\(fileUrl)|")
        print("FileURL PTH=\(fileUrl.path)|")
        do {
            
            try text.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
            
        } catch {
            print("ERROR=\(error)")
            print("ERROR LD=\(error.localizedDescription)")
            print("An error occured writing file:" + received)
        }
        
        
        let str = "Super long string here"
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")

        do {
            try str.write(to: filename, atomically: true, encoding: .utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
        return fileUrl.path
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
