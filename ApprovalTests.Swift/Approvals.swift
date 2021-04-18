import Foundation

public class Approvals {
    public class NameCreator: Loader {
        public func load(_ file: String) -> ApprovalNamer {
            Namer(file)
        }
    }

    class func getNamer(file: StaticString = #filePath) -> ApprovalNamer {
        NameCreator().load(file.description)
    }

    public static func verifyAsJson<INOBJ: Codable>(_ object: INOBJ,
                                                    _ reporter: ApprovalFailureReporter = getReporter(),
                                                    file: StaticString = #filePath) throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(object)
            let jsonString = (String(data: jsonData, encoding: .utf8) ?? "")
            try verify(jsonString, reporter: reporter, file: file)
        } catch {
            print(error.localizedDescription)
        }
    }

    public static func verifyAll(_ label: String, _ array: [Any],
                                 _ reporter: ApprovalFailureReporter = getReporter(),
                                 file: StaticString = #filePath) throws {
        try verify(ApprovalTextWriter(StringUtils.toString(label, array), "txt"), reporter, file)
    }

    public static func verify(_ response: String,
                              reporter: ApprovalFailureReporter = getReporter(),
                              file: StaticString = #filePath) throws {
        try verify(ApprovalTextWriter(response, "txt"), reporter, file);
    }

    private class func verify(_ writer: ApprovalTextWriter,
                              _ reporter: ApprovalFailureReporter = getReporter(),
                              _ file: StaticString) throws {
        try verify(writer, createApprovalNamer(file.description), reporter, file);
    }

    private class func verify(_ writer: ApprovalTextWriter,
                              _ namer: ApprovalNamer,
                              _ reporter: ApprovalFailureReporter,
                              _ file: StaticString) throws {
        try verify(FileApprover(writer: writer, namer: namer), reporter, file);
    }

    private class func verify(_ approver: FileApprover, _ reporter: ApprovalFailureReporter,
                              _ file: StaticString) throws {
        try verify(approver, file, Options(reporter: reporter))
    }

    private class func verify(_ approver: FileApprover,
                              _ file: StaticString,
                              _ options: Options = Options()) throws {
        let reporter = options.getReporter()
        if !approver.approve() {
            approver.reportFailure(reporter: reporter);
            try approver.fail();
        } else {
            approver.cleanUpAfterSuccess(reporter: reporter);
        }
    }

    public static func verify<INOBJ>(_ object: INOBJ,
                                     _ reporter: ApprovalFailureReporter = getReporter(),
                                     file: StaticString = #filePath) throws {
        let description = String(describing: type(of: object.self)) + String(describing: object)
        try verify(description, reporter: reporter, file: file)
    }

    public static func createApprovalNamer(_ file: String) -> ApprovalNamer {
        NameCreator().load(file)
    }

    public static func getReporter() -> ApprovalFailureReporter {
        ReporterFactory.get()
    }

}
