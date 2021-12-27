import Foundation

public enum Approvals {
    public static func makeNamer(forFile file: String) -> ApprovalNamer {
        Namer(file)
    }

    public static var reporter: ApprovalFailureReporter {
        ReporterFactory.get
    }

    /**
     Verify an object converted to JSON
     
     Use this to verify anything that is Encodable. A handy way to verify any composite object is
     to declare it (and its properties) as Encodable from within your test code.
     */
    public static func verifyAsJSON<T: Encodable>(_ object: T,
                                                  _ options: Options = Options(),
                                                  file: StaticString = #filePath,
                                                  line: UInt = #line) throws {
        try verify(StringUtils.toJSON(object), options.forFile.withExtension(".json"), file: file, line: line)
    }

    /// Verify a string
    public static func verify(_ response: String,
                              _ options: Options = Options(),
                              file: StaticString = #filePath,
                              line: UInt = #line
    ) throws {
        try verify(
                ApprovalTextWriter(options.scrub(response), options.forFile.fileExtensionWithoutDot),
                options,
                file: file, line: line
        )
    }

    /// Verify an object that describes itself
    public static func verify<T>(_ object: T,
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        let description = String(describing: type(of: object.self)) + ": " + String(describing: object)
        try verify(description, options, file: file, line: line)
    }

    /// Verify an array
    public static func verify<T>(_ array: [T],
                                 label: String,
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        try verify(StringUtils.toString(label, array), options, file: file, line: line)
    }

    /// Verify a dictionary
    public static func verify<Key: Hashable & Comparable, Value>(_ object: [Key: Value],
                                                                 _ options: Options = Options(),
                                                                 file: StaticString = #filePath,
                                                                 line: UInt = #line) throws {
        try verify(StringUtils.printDictionary(object), options, file: file, line: line)
    }

    /**
     Verify a query crosses an architectural boundary
     
     What is a query that crosses an architectural boundary? It can be a network call, or any other
     slow or expensive operation that you don't want in fast unit tests.
     
     Make your query conform to ExecutableQuery from within your test code. Then verify will use a
     special reporter that verifies the request expressed as a string by getQuery(). If the query
     has changed, then it is also executed with executeQuery(_:). This gives you a chance to examine
     the response so that you can decide whether to approve the new query.
     */
    public static func verify(_ query: ExecutableQuery,
                              _ options: Options = Options(),
                              file: StaticString = #filePath,
                              line: UInt = #line) throws {
        try verify(query.getQuery(), ExecutableReporter.wrap(options, query), file: file, line: line)
    }

    /**
     Verify a sequence of frames to see how they change
     */
    public static func verifySequence<T>(_ initial: T,
                                         _ numberOfFrames: Int,
                                         _ getNextFrame: (Int) -> T,
                                         _ options: Options = Options(),
                                         file: StaticString = #filePath,
                                         line: UInt = #line) throws {
        var output = """
                     initial:
                     \(initial)


                     """
        for frame in 1 ... numberOfFrames {
            output += """
                      frame #\(frame):
                      \(getNextFrame(frame))


                      """
        }
        try verify(output, options, file: file, line: line)
    }
}

extension Approvals {
    private static func verify(_ writer: ApprovalTextWriter,
                               _ options: Options = Options(),
                               file: StaticString,
                               line: UInt) throws {
        try verify(writer, makeNamer(forFile: file.description), options, file: file, line: line)
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
}
