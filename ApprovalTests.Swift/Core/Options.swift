// swiftlint:disable strict_fileprivate

private enum OptionDataKey {
    case namer
    case reporter
    case scrubber
    case fileExtension
}

private typealias OptionData = [OptionDataKey: Any]

/**
 Specify options for any ApprovalTests verification.

 Every `verify()` call takes Options as an optional parameter.
 - **Reporters** launch diff tools upon failure.
 - **Scrubbers** clean output to help remove inconsistent pieces of text, such as dates.
 - **File Options** customizes the `.approved` and `.received` files. For now, it just controls the file extension.

 Options is a fluent interface, allowing you to chain them together. Each returned object is a new copy. Example:
 ````
 Options()
     .with(reporter: ReportWithKaleidoscope())
     .with(scrubber: ScrubDates())
     .forFile.with(fileExtensionWithDot: ".json")
 ````

 By default, Options does:
 - no scrubbing
 - uses file extension `.txt`
 - uses whatever is currently set as the default reporter.
 */
public struct Options {
    public func and(_ closure: (Options) -> Options) -> Options {
        return closure(self)
    }

    private let data: OptionData

    public init() {
        data = [:]
    }

    public init(_ reporter: ApprovalFailureReporter) {
        data = [.reporter: reporter]
    }

    public init(_ scrubber: Scrubber) {
        data = [.scrubber: scrubber]
    }

    fileprivate init(_ data: OptionData, key: OptionDataKey, value: Any) {
        var d = data
        d[key] = value
        self.data = d
    }

    public var reporter: ApprovalFailureReporter {
        data[.reporter] as? ApprovalFailureReporter ?? Approvals.reporter
    }

    public var scrubber: Scrubber {
        data[.scrubber] as? Scrubber ?? ScrubNothing()
    }

    public func with(namerCreator: @escaping (String) -> ApprovalNamer) -> Options {
        Options(data, key: .namer, value: namerCreator)
    }

    public func with(reporter: ApprovalFailureReporter) -> Options {
        Options(data, key: .reporter, value: reporter)
    }

    public func with(scrubber: Scrubber) -> Options {
        Options(data, key: .scrubber, value: scrubber)
    }

    public func scrub(_ input: String) throws -> String {
        scrubber.scrub(input)
    }

    public var forFile: FileOptions {
        FileOptions(data)
    }

    public func getNamer(_ path: String) -> ApprovalNamer {
        let c = data[.namer] as? (String) -> ApprovalNamer ?? Approvals.makeNamer
        return c(path)
    }
}

public struct FileOptions {
    private let data: OptionData

    fileprivate init(_ data: OptionData) {
        self.data = data
    }

    public var fileExtensionWithDot: String {
        data[.fileExtension] as? String ?? ".txt"
    }

    public var fileExtensionWithoutDot: String {
        String(fileExtensionWithDot.dropFirst())
    }

    public func with(extensionWithDot: String) -> Options {
        Options(data, key: .fileExtension, value: extensionWithDot)
    }
}
