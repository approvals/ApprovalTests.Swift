public enum ReporterFactory {
    public static var defaultReporter: () -> ApprovalFailureReporter = {
        ReportWithDiffTool()
    }

    public static var get: ApprovalFailureReporter {
        defaultReporter()
    }

    public static func registerDefaultReporter(_ newReporterCreator: @escaping () -> ApprovalFailureReporter) -> DefaultReporterDisposer {
        DefaultReporterDisposer(newReporterCreator)
    }
}

public class DefaultReporterDisposer {
    private let oldCreator: () -> ApprovalFailureReporter

    public init(_ newCreator: @escaping () -> ApprovalFailureReporter) {
        oldCreator = ReporterFactory.defaultReporter
        ReporterFactory.defaultReporter = newCreator
    }

    deinit {
        ReporterFactory.defaultReporter = oldCreator
    }
}
