import Foundation

struct ApprovalTextWriter: ApprovalWriter {
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

    func approvalFilename(_ base: String) -> String {
        "\(base).approved.\(fileExtensionWithoutDot)"
    }

    func receivedFilename(_ base: String) -> String {
        "\(base).received.\(fileExtensionWithoutDot)"
    }

    func writeReceivedFile(_ received: String) {
        let fileUrl = URL(fileURLWithPath: received)
        do {
            try text.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
        } catch {
            print("Error in \(#function) for received \"\(received)\": \(error)")
        }
    }
}
