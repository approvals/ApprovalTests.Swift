import Foundation

public class Approvals {
    public class NameCreator: Loader {
        public func load(_ file: String) -> ApprovalNamer{
            return Namer(file)
        }
    }

    class func getNamer( file: StaticString = #file ) -> ApprovalNamer {
        return NameCreator().load(file.description)
    }

    class func verify(_ object: Any, file: StaticString = #file) throws {
        let description = String(describing: type(of: object.self)) + String(describing: object)
        try verify(description, file: file)
    }

    public static func verify(_ response: String,
                              _ reporter: ApprovalFailureReporter = getReporter(),
                              file: StaticString = #file) throws {

        try verify( ApprovalTextWriter(response, "txt"), reporter, file);
    }

    public static func verifyAll(_ label: String, _ array: [Any],
                                 _ reporter: ApprovalFailureReporter = getReporter(),
                                 file: StaticString = #file) throws {
        try verify( ApprovalTextWriter(StringUtils.toString(label, array), "txt"), reporter, file)
    }

    private class func verify(_ writter: ApprovalTextWriter,
                              _ reporter: ApprovalFailureReporter = getReporter(),
                              _ file: StaticString) throws {
        try verify(writter, createApprovalNamer(file.description), reporter, file);
    }

    private class func verify(_ writter: ApprovalTextWriter,
                              _ namer: ApprovalNamer,
                              _ reporter: ApprovalFailureReporter,
                              _ file: StaticString) throws {
        try verify(FileApprover(writter, namer), reporter, file);
    }

    private class func verify(_ approver: FileApprover, _ reporter: ApprovalFailureReporter,
                              _ file: StaticString) throws {
        if (!approver.approve()) {
            approver.reportFailure(reporter: reporter);
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
