//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

class FileApprover: ApprovalApprover {
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
        received = writter.writeReceivedFile(received: received)
        return approveTextFile(approved: approved, received: received);
    }

    func approveTextFile(approved expected: String, received actual: String) -> Bool {
        let fileManager = FileManager.default
        let expectedExists = fileManager.fileExists(atPath: expected)
        let actualExists = fileManager.fileExists(atPath: actual)

        if( !expectedExists ) {
            fileManager.createFile(atPath: expected, contents: Data())
        }

        if( !actualExists ) { return false }

        let expectedUrl = URL(string: expected)
        let actualUrl = URL(string: actual)

        var t1 = ""
        var t2 = ""
        do {
            t1 = try String(contentsOf: expectedUrl!)
            t2 = try String(contentsOf: actualUrl!)
        }
        catch {/* error handling here */}

        return t1 == t2
    }

    func cleanUpAfterSuccess(reporter: ApprovalFailureReporter) {
    }

    func fail() {
    }

    func reportFailure(reporter: ApprovalFailureReporter) {
        reporter.report(received: received, approved: approved)
    }
}
