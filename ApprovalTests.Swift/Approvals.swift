import Foundation

public enum Approvals {
    public static func makeNamer(forFile file: String) -> ApprovalNamer {
        Namer(file)
    }

    public static var reporter: ApprovalFailureReporter {
        ReporterFactory.get
    }

    /// Verifies a string against a previously approved version of the string.
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

    /// Verifies an object that describes itself against a previously approved description.
    public static func verify<T>(_ object: T,
                                 _ options: Options = Options(),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) throws {
        let description = String(describing: type(of: object.self)) + ": " + String(describing: object)
        try verify(description, options, file: file, line: line)
    }

    /// Verifies a dictionary of items against a previously approved dictionary.
    public static func verify<Key: Hashable & Comparable, Value>(_ object: [Key: Value],
                                                                 _ options: Options = Options(),
                                                                 file: StaticString = #filePath,
                                                                 line: UInt = #line) throws {
        try verify(StringUtils.printDictionary(object), options, file: file, line: line)
    }

    /**
     Verifies an array of items against a previously approved array.

     Each element of the array is on a separate line, preceded by the label and its array index.

     - Parameters:
       - array: Array to verify.
       - label: Optional string to label each element: `label[n] = value`.
       - options: Optional verification options.
     */
    public static func verifyAll<T>(_ array: [T],
                                    label: String = "",
                                    _ options: Options = Options(),
                                    file: StaticString = #filePath,
                                    line: UInt = #line) throws {
        try verify(StringUtils.toString(array, name: label), options, file: file, line: line)
    }

    /**
     Verifies an object as converted to JSON.
     
     Use this to verify anything that is `Encodable`. A handy way to verify a composite object is to declare it (and its properties) as `Encodable` from within your test code using extensions.
     */
    public static func verifyAsJSON<T: Encodable>(_ object: T,
                                                  _ options: Options = Options(),
                                                  file: StaticString = #filePath,
                                                  line: UInt = #line) throws {
        try verify(StringUtils.toJSON(object), options.forFile.with(extensionWithDot: ".json"), file: file, line: line)
    }

    /**
     Verifies a query that crosses an architectural boundary.
     
     What is a such a query? It can be a network call, or any other slow or expensive operation that you don't want in fast-running unit tests.
     
     Make your query conform to `ExecutableQuery` from within your test code. Then verify will use a special reporter that verifies the request expressed as a string by `getQuery()`. If the query has changed, then it is also executed with `executeQuery(_:)`. This gives you a chance to examine the response so that you can decide whether to approve the new query.
     */
    public static func verify(_ query: ExecutableQuery,
                              _ options: Options = Options(),
                              file: StaticString = #filePath,
                              line: UInt = #line) throws {
        try verify(query.getQuery(), ExecutableReporter.wrap(options, query), file: file, line: line)
    }

    /**
     Verifies a sequence to see how each frame changes.

     - Parameters:
       - initial: Starting point. 
       - numberOfFrames: Number of frames to generate after the initial starting point.
       - getNextFrame: Generates next frame. The closure takes the frame index as an argument, which you are free to use or ignore.
       - options: Optional verification options.
     */
    public static func verifySequence<T>(_ initial: T,
                                         numberOfFrames: Int,
                                         getNextFrame: (Int) -> T,
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
