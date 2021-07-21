class ReporterFactory {
    static var defaultReporter: () -> ApprovalFailureReporter = { () -> ApprovalFailureReporter in
        #if os(OSX)
            let returned = ReportersForMac()
        #elseif os(iOS)
            let returned = ReportersForiOS()
        #endif
        return returned
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
