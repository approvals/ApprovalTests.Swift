class ReporterFactory {
    static var defaultReporter: () -> ApprovalFailureReporter = { () -> ApprovalFailureReporter in
        return DefaultReporter()
    }

    public static var get: ApprovalFailureReporter {
        return defaultReporter()
    }
    
    public static func registerDefaultReporter(_ newReporterCreator: @escaping () -> ApprovalFailureReporter) -> DefaultReporterDisposer {
        return DefaultReporterDisposer(newReporterCreator)
    }
}

class DefaultReporterDisposer {
    private let oldCreator: () -> ApprovalFailureReporter 

    init(_ newCreator: @escaping () -> ApprovalFailureReporter) {
        self.oldCreator = ReporterFactory.defaultReporter
        ReporterFactory.defaultReporter = newCreator
    }

    deinit {
        ReporterFactory.defaultReporter = oldCreator
    }
}

#if os(OSX)
    public typealias DefaultReporter = ReportersForMac
#elseif os(iOS)
    public typealias DefaultReporter = ReportersForiOS
#endif
