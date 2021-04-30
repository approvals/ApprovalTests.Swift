public class Options {
    private let data: [String : Any]

    public init() {
        data = [:]
    }

    public init(reporter: ApprovalFailureReporter) {
        data = ["reporter": reporter]
    }
    
    public init(_ scrubber: Scrubber) {
        data = ["scrubber": scrubber]
    }

    private init(_ data: [String: Any], key: String, value: Any) {
        var d: [String: Any] = data
        d[key] = value
        self.data = d
    }

    public func getReporter() -> ApprovalFailureReporter {
        data["reporter"] as? ApprovalFailureReporter ?? Approvals.getReporter()
    }

    public func getScrubber() -> Scrubber {
        data["scrubber"] as? Scrubber ?? ScrubNothing()
    }

    public func withReporter(_ reporter: ApprovalFailureReporter) -> Options {
        Options(data, key: "reporter", value: reporter)
    }

    func scrub(_ input: String) throws -> String {
        getScrubber().scrub(input)
    }
}
