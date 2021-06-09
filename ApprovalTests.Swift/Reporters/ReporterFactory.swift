enum ReporterFactory {
    static var get: ApprovalFailureReporter {
        #if os(OSX)
            let returned = ReportersForMac()
        #elseif os(iOS)
            let returned = XCTReporter()
        #endif
        return returned
    }
}
