import Foundation

public class FileApprover: ApprovalApprover {
    private static var failer: Failer = XCTFailer()

    public static func registerFailer(_ failer: Failer) {
        FileApprover.failer = failer
    }

    public static func resetFailer() {
        FileApprover.failer = XCTFailer()
    }

    private let fileManager = FileManager.default
    private let received: String
    private let approved: String
    private let writer: ApprovalWriter

    public init(_ writer: ApprovalWriter, _ namer: ApprovalNamer) {
        let base = namer.sourceFilePath()
        received = writer.receivedFilename(base)
        approved = writer.approvalFilename(base)
        self.writer = writer
    }

    public func approve() -> Bool {
        writer.writeReceivedFile(received)
        return approveFile(approved: approved, received: received)
    }

    private func approveFile(approved expected: String, received actual: String) -> Bool {
        guard fileManager.fileExists(atPath: actual) else { return false }
        if !fileManager.fileExists(atPath: expected) {
            fileManager.createFile(atPath: expected, contents: Data())
        }

        guard let t1 = FileManager.default.contents(atPath: expected) else {
            print("Error in \(#function) reading expected \"\(expected)\"")
            return false
        }
        guard let t2 = FileManager.default.contents(atPath: actual) else {
            print("Error in \(#function) reading actual \"\(actual)\"")
            return false
        }
        return t1 == t2
    }

    public func cleanUpAfterSuccess(reporter: ApprovalFailureReporter) {
        do {
            try fileManager.removeItem(atPath: received)
        } catch {
            print("Error in \(#function): \(error)")
        }
    }

    public func fail(file: StaticString, line: UInt) throws {
        let message = "Failed Approval \nApproved:\(approved) \nReceived:\(received)"
        try FileApprover.failer.fail(message, file: file, line: line)
    }

    public func reportFailure(reporter: ApprovalFailureReporter) {
        _ = reporter.report(received: received, approved: approved)
    }
}
