//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

public class Approvals {
    public class NameCreator: Loader {
        public func load(_ file: String) -> ApprovalNamer{
            return Namer(file)
        }
    }

    public static func verify(_ response: String,
                              file: StaticString = #file, line: UInt = #line) throws {

        try verify( ApprovalTextWriter(response, "txt"), file, line);
    }

    private class func verify(_ writter: ApprovalTextWriter, _ file: StaticString, _ line: UInt) throws {
        try verify(writter, createApprovalNamer(file.description), getReporter(), file, line);
    }

    private class func verify(_ writter: ApprovalTextWriter,
                              _ namer: ApprovalNamer,
                              _ reporter: ApprovalFailureReporter,
                              _ file: StaticString,
                              _ line: UInt) throws {
        try verify(FileApprover(writter, namer), reporter, file, line);
    }

    private class func verify(_ approver: FileApprover, _ reporter: ApprovalFailureReporter,
                              _ file: StaticString, _ line: UInt) throws {
        if (!approver.approve()) {
            approver.reportFailure(reporter: reporter);
            let message = "File:" + file.description + " Line:" + line.description
            print(message)
            try approver.fail();
        } else {
            approver.cleanUpAfterSuccess(reporter: reporter);
        }
    }

    public static func createApprovalNamer(_ file: String) -> ApprovalNamer {
        return NameCreator().load(file)
    }

    public static func getReporter() -> ApprovalFailureReporter {
        return ReporterFactory.get()
    }

}
