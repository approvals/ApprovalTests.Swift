//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

class Approvals {

    public class NameCreator: Loader {
        public func load() -> ApprovalNamer{
            return Namer()
        }
    }

    public static func verify(_ response: String) {
        verify( ApprovalTextWriter(response, "txt"));
    }

    private class func verify(_ writter: ApprovalTextWriter) {
        verify(writter, createApprovalNamer(), getReporter());
    }

    private class func verify(_ writter: ApprovalTextWriter,
                              _ namer: ApprovalNamer,
                              _ reporter: ApprovalFailureReporter) {
        verify(FileApprover(writter, namer), reporter);
    }

    private class func verify(_ approver: FileApprover, _ reporter: ApprovalFailureReporter) {
        if (!approver.approve()) {
            approver.reportFailure(reporter: reporter);
            approver.fail();
        } else {
            approver.cleanUpAfterSuccess(reporter: reporter);
        }
    }

    public static func createApprovalNamer() -> ApprovalNamer {
        return NameCreator().load()
    }

    public static func getReporter() -> ApprovalFailureReporter {
        return ReporterFactory.get()
    }

}