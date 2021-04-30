public class Options {
    private let data: [String : Any]

    public init() {
        data = [:]
    }

    public init(_ reporter: ApprovalFailureReporter) {
        data = ["reporter": reporter]
    }
    
    public init(_ scrubber: Scrubber) {
        data = ["scrubber": scrubber]
    }

    fileprivate init(_ data: [String: Any], key: String, value: Any) {
        var d: [String: Any] = data
        d[key] = value
        self.data = d
    }

    public var getReporter: ApprovalFailureReporter {
        data["reporter"] as? ApprovalFailureReporter ?? Approvals.getReporter
    }

    public func getScrubber() -> Scrubber {
        data["scrubber"] as? Scrubber ?? ScrubNothing()
    }

    public func withReporter(_ reporter: ApprovalFailureReporter) -> Options {
        Options(data, key: "reporter", value: reporter)
    }

    public func withScrubber(_ scrubber: Scrubber) -> Options {
        Options(data, key: "scrubber", value: scrubber)
    }

    func scrub(_ input: String) throws -> String {
        getScrubber().scrub(input)
    }

    public func forFile() -> FileOptions {
        FileOptions(self.data)
    }
}

public class FileOptions {
    private let data: [String: Any]

    public func withExtension(_ extensionWithDot: String) -> Options {
        Options(data, key: "fileExtension", value: extensionWithDot)
    }

    public init(_ data: [String: Any]) {
        self.data = data
    }

    public var getFileExtensionWithDot: String {
        data["fileExtension"] as? String ?? ".txt"
    }

    public var getFileExtensionWithoutDot: String {
        String(getFileExtensionWithDot.dropFirst())
    }
}
