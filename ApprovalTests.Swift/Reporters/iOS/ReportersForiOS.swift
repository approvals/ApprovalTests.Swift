class ReportersForiOS: FirstWorkingReporter {
    init() {
        #if os(iOS)
            super.init(
                    // begin-snippet: ios_reporters
                    XCTReporter()
                    // end-snippet
            )
        #endif
    }
}
