import Foundation

class FileApprover: ApprovalApprover {
    private static var failer: Failer = XCTFailer()

    static func registerFailer(_ failer: Failer) {
        FileApprover.failer = failer
    }

    static func resetFailer() {
        FileApprover.failer = XCTFailer()
    }

    private let fileManager = FileManager.default
    private let received: String
    private let approved: String
    private let writer: ApprovalWriter

    init(_ writerIn: ApprovalWriter, _ namerIn: ApprovalNamer) {
        let base = namerIn.getSourceFilePath()
        received = writerIn.getReceivedFilename(base: base)
        approved = writerIn.getApprovalFilename(base: base)
        writer = writerIn
    }

    func approve() -> Bool {
        let _ = writer.writeReceivedFile(received: received)
        return approveTextFile(approved: approved, received: received);
    }

    func approveTextFile(approved expected: String, received actual: String) -> Bool {
        let expectedExists = fileManager.fileExists(atPath: expected)
        let actualExists = fileManager.fileExists(atPath: actual)

        if !expectedExists {
            fileManager.createFile(atPath: expected, contents: Data())
        }

        if !actualExists { return false }

        let expectedUrl = URL(fileURLWithPath: expected)
        let actualUrl = URL(fileURLWithPath: actual)

        var t1 = ""
        var t2 = ""
        do {
            t1 = try String(contentsOf: expectedUrl)
            t2 = try String(contentsOf: actualUrl)
        } catch { /* error handling here */ }

        return t1 == t2
    }

    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter) {
        do {
            try fileManager.removeItem(atPath: received)
        } catch {
        }
    }

    func fail() throws {
        let message = "Failed Approval \nApproved:\(approved) \nReceived:\(received)"
        try FileApprover.failer.fail(message)
    }

    func reportFailure(reporter: ApprovalFailureReporter) {
        _ = reporter.report(received: received, approved: approved)
    }
}
