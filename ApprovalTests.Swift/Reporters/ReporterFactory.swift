enum ReporterFactory {
    public static var get: ApprovalFailureReporter {
        #if os(OSX)
            let returned = ReportersForMac()
        #elseif os(iOS)
            let returned = ReportersForiOS()
        #endif
        return returned
    }
}
