class iOSReporter: FirstWorkingReporter {
    init() {
        #if os(iOS)
            super.init(
                    XCTReporter()
            )
        #endif
    }
}
