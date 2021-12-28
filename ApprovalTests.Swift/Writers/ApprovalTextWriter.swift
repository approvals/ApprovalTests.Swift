import Foundation

public struct ApprovalTextWriter: ApprovalWriter {
    private let text: String
    private let fileExtensionWithoutDot: String

    public init(_ text: String, _ fileExtensionWithoutDot: String) {
        self.text = StringUtils.endWithNewline(text)
        self.fileExtensionWithoutDot = fileExtensionWithoutDot
    }

    public func approvalFilename(_ base: String) -> String {
        "\(base).approved.\(fileExtensionWithoutDot)"
    }

    public func receivedFilename(_ base: String) -> String {
        "\(base).received.\(fileExtensionWithoutDot)"
    }

    public func writeReceivedFile(_ received: String) {
        let fileURL = URL(fileURLWithPath: received)
        do {
            try text.write(toFile: fileURL.path, atomically: true, encoding: .utf8)
        } catch {
            print("Error in \(#function) for received \"\(received)\": \(error)")
        }
    }
}
