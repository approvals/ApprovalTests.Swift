enum ReporterFactory {
public static var get: ApprovalFailureReporter {
        #if os(OSX)
            let returned = ReportersForMac()
        #elseif os(iOS)
            let returned = ReportContentsWithXCTest()
        #endif
        return returned
    }
}
