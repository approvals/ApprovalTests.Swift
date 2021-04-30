import Foundation

public enum Approvals {
    public class NameCreator: Loader {
        public func load(_ file: String) -> ApprovalNamer {
            Namer(file)
        }
    }

    static func getNamer(file: StaticString = #filePath) -> ApprovalNamer {
        NameCreator().load(file.description)
    }

    public static func verifyAsJson<T: Encodable>(
            _ object: T,
            _ options: Options = Options(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        try verify(StringUtils.toJson(object), options.forFile().withExtension(".json"), file: file, line: line)
    }

    public static func verifyAll(
            _ label: String,
            _ array: [Any],
            _ options: Options = Options(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        try verify(StringUtils.toString(label, array), options, file: file, line: line)
    }

    public static func verify(
            _ response: String,
            _ options: Options = Options(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        try verify(ApprovalTextWriter(options.scrub(response), options.forFile().getFileExtensionWithoutDot), options, file: file, line: line);
    }

    private static func verify(
            _ writer: ApprovalTextWriter,
            _ options: Options = Options(),
            file: StaticString,
            line: UInt) throws {
        try verify(writer, createApprovalNamer(file.description), options, file: file, line: line);
    }

    private static func verify(
            _ writer: ApprovalTextWriter,
            _ namer: ApprovalNamer,
            _ options: Options = Options(),
            file: StaticString,
            line: UInt) throws {
        try verify(FileApprover(writer, namer), file: file, line: line, options);
    }

    private static func verify(
            _ approver: FileApprover,
            file: StaticString,
            line: UInt,
            _ options: Options = Options()) throws {
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
            _ options: Options = Options(),
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let description = String(describing: type(of: object.self)) + String(describing: object)
        try verify(description, options, file: file, line: line)
    }

    public static func createApprovalNamer(_ file: String) -> ApprovalNamer {
        NameCreator().load(file)
    }
    
    public static var getReporter: ApprovalFailureReporter {
        ReporterFactory.get()
    }
}
