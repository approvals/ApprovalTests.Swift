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

    init(_ writer: ApprovalWriter, _ namer: ApprovalNamer) {
        let base = namer.sourceFilePath()
        received = writer.receivedFilename(base: base)
        approved = writer.approvalFilename(base: base)
        self.writer = writer
    }

    func approve() -> Bool {
        writer.writeReceivedFile(received)
        return approveTextFile(approved: approved, received: received)
    }

    private func approveTextFile(approved expected: String, received actual: String) -> Bool {
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
        } catch {
            print("Error in \(#function) for approved \"\(expected)\", received \"\(actual)\": \(error)")
        }

        return t1 == t2
    }

    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter) {
        do {
            try fileManager.removeItem(atPath: received)
        } catch {
            print("Error in \(#function): \(error)")
        }
    }

    func fail(file: StaticString, line: UInt) throws {
        let message = "Failed Approval \nApproved:\(approved) \nReceived:\(received)"
        try FileApprover.failer.fail(message, file: file, line: line)
    }

    func reportFailure(reporter: ApprovalFailureReporter) {
        _ = reporter.report(received: received, approved: approved)
    }
}
