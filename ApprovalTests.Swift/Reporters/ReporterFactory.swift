enum ReporterFactory {
    public static var get: ApprovalFailureReporter {
        #if os(OSX)
            let returned = MacReporter()
        #elseif os(iOS)
            let returned = XCTReporter()
        #endif
        return returned
    }
}
