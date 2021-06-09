import Foundation

public enum Approvals {
    class NameCreator: Loader {
        func load(_ file: String) -> ApprovalNamer {
            Namer(file)
        }
    }
    
    static func makeApprovalNamer(forFile file: String) -> ApprovalNamer {
        NameCreator().load(file)
    }

    public static var reporter: ApprovalFailureReporter {
        ReporterFactory.get
    }

    public static func verifyAsJSON<T: Encodable>(_ object: T,
                                                  _ options: Options = Options(),
                                                  file: StaticString = #filePath,
                                                  line: UInt = #line) throws {
        try verify(StringUtils.toJSON(object), options.forFile.withExtension(".json"), file: file, line: line)
    }

    public static func verifyAll(_ label: String,
                                 _ array: [Any],
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        try verify(StringUtils.toString(label, array), options, file: file, line: line)
    }

    public static func verify(_ response: String,
                              _ options: Options = Options(),
                              file: StaticString = #filePath,
                              line: UInt = #line
    ) throws {
        try verify(ApprovalTextWriter(options.scrub(response), options.forFile.fileExtensionWithoutDot), options, file: file, line: line)
    }

    private static func verify(_ writer: ApprovalTextWriter,
                               _ options: Options = Options(),
                               file: StaticString,
                               line: UInt) throws {
        try verify(writer, makeApprovalNamer(forFile: file.description), options, file: file, line: line)
    }

    private static func verify(_ writer: ApprovalTextWriter,
                               _ namer: ApprovalNamer,
                               _ options: Options = Options(),
                               file: StaticString,
                               line: UInt) throws {
        try verify(FileApprover(writer, namer), options, file: file, line: line)
    }

    private static func verify(_ approver: FileApprover,
                               _ options: Options = Options(),
                               file: StaticString,
                               line: UInt) throws {
        let reporter = options.reporter
        if !approver.approve() {
            approver.reportFailure(reporter: reporter)
            try approver.fail(file: file, line: line)
        } else {
            approver.cleanUpAfterSuccess(reporter: reporter)
        }
    }

    public static func verify<T>(_ object: T,
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        let description = String(describing: type(of: object.self)) + String(describing: object)
        try verify(description, options, file: file, line: line)
    }

    public static func verify<Key: Hashable & Comparable, Value>(_ object: [Key: Value],
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        try verify(StringUtils.printDictionary(object), options, file: file, line: line)
    }
}
