import Foundation

class ApprovalTextWriter: ApprovalWriter {
    private let text: String
    private let fileExtensionWithoutDot: String

    init(_ text: String, _ fileExtensionWithoutDot: String) {
        if !text.hasSuffix("\n") {
            self.text = text.appending("\n")
        } else {
            self.text = text
        }
        self.fileExtensionWithoutDot = fileExtensionWithoutDot
    }

    func getApprovalFilename(base: String) -> String {
        "\(base).approved.\(fileExtensionWithoutDot)"
    }

    func getReceivedFilename(base: String) -> String {
        "\(base).received.\(fileExtensionWithoutDot)"
    }

    func writeReceivedFile(_ received: String) -> String {
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
