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
        return approveTextFile(approved: approved, received: received)
    }

    private func approveTextFile(approved expected: String, received actual: String) -> Bool {
        guard fileManager.fileExists(atPath: actual) else { return false }
        if !fileManager.fileExists(atPath: expected) {
            fileManager.createFile(atPath: expected, contents: Data())
        }

        do {
            let t1 = try String(contentsOfFile: expected)
            let t2 = try String(contentsOfFile: actual)
            return t1 == t2
        } catch {
            print("Error in \(#function) for approved \"\(expected)\", received \"\(actual)\": \(error)")
            return false
        }
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
