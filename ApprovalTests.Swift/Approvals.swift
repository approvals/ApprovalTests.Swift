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

    public static func verifyAsJson<T: Encodable>(
            _ object: T,
            _ reporter: ApprovalFailureReporter = getReporter(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(object)
            let jsonString = (String(data: jsonData, encoding: .utf8) ?? "")
            try verify(jsonString, reporter: reporter, file: file, line: line)
        } catch {
            print(error.localizedDescription)
        }
    }

    public static func verifyAll(
            _ label: String,
            _ array: [Any],
            _ reporter: ApprovalFailureReporter = getReporter(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        try verify(writer: ApprovalTextWriter(StringUtils.toString(label, array), "txt"), reporter: reporter, file: file, line: line)
    }

    public static func verify(
            _ response: String,
            reporter: ApprovalFailureReporter = getReporter(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        try verify(writer: ApprovalTextWriter(response, "txt"), reporter: reporter, file: file, line: line);
    }

    private class func verify(
            writer: ApprovalTextWriter,
            reporter: ApprovalFailureReporter = getReporter(),
            file: StaticString,
            line: UInt
    ) throws {
        try verify(writer: writer, namer: createApprovalNamer(file.description), reporter: reporter, file: file, line: line);
    }

    private class func verify(
            writer: ApprovalTextWriter,
            namer: ApprovalNamer,
            reporter: ApprovalFailureReporter,
            file: StaticString,
            line: UInt
    ) throws {
        try verify(approver: FileApprover(writer: writer, namer: namer), reporter: reporter, file: file, line: line);
    }

    private class func verify(
            approver: FileApprover,
            reporter: ApprovalFailureReporter,
            file: StaticString,
            line: UInt
    ) throws {
        try verify(approver: approver, file: file, options: Options(reporter: reporter), line: line)
    }

    private class func verify(
            approver: FileApprover,
            file: StaticString,
            options: Options = Options(),
            line: UInt
    ) throws {
        let reporter = options.getReporter()
        if !approver.approve() {
            approver.reportFailure(reporter: reporter);
            try approver.fail(file: file, line: line);
        } else {
            approver.cleanUpAfterSuccess(reporter: reporter);
        }
    }

    public static func verify<T>(
            _ object: T,
            _ reporter: ApprovalFailureReporter = getReporter(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let description = String(describing: type(of: object.self)) + String(describing: object)
        try verify(description, reporter: reporter, file: file, line: line)
    }

    public static func createApprovalNamer(_ file: String) -> ApprovalNamer {
        NameCreator().load(file)
    }

    public static func getReporter() -> ApprovalFailureReporter {
        ReporterFactory.get()
    }

}
