import Foundation

class FileApprover: ApprovalApprover {
    let fileManager = FileManager.default

    var received: String
    var approved: String
    var writter: ApprovalWriter

    init(_ writterIn: ApprovalWriter, _ namerIn: ApprovalNamer) {
        let base = namerIn.getSourceFilePath()
        received = writterIn.getReceivedFilename(base: base)
        approved = writterIn.getApprovalFilename(base: base)
        writter = writterIn
    }

    func approve() -> Bool {
        let _ = writter.writeReceivedFile(received: received)
        return approveTextFile(approved: approved, received: received);
    }

    func approveTextFile(approved expected: String, received actual: String) -> Bool {
        let expectedExists = fileManager.fileExists(atPath: expected)
        let actualExists = fileManager.fileExists(atPath: actual)

        if( !expectedExists ) {
            fileManager.createFile(atPath: expected, contents: Data())
        }

        if( !actualExists ) { return false }

        let expectedUrl = URL(fileURLWithPath: expected)
        let actualUrl = URL(fileURLWithPath: actual)

        var t1 = ""
        var t2 = ""
        do {
            t1 = try String(contentsOf: expectedUrl)
            t2 = try String(contentsOf: actualUrl)
        }
        catch {/* error handling here */}

        return t1 == t2
    }

    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter) {
        do {
            try fileManager.removeItem(atPath: received)
        } catch {
        }
    }

    func fail() throws {
        // @ToDo: Add Error Handeling
        throw ApprovalError.Error("Failed Approval \nApproved:\(approved) \nReceived:\(received)")
    }

    func reportFailure(reporter: ApprovalFailureReporter) {
        _ = reporter.report(received: received, approved: approved)
    }
}
