class MacReporter: FirstWorkingReporter {
    init() {
        #if os(macOS)
            super.init(
                    // begin-snippet: mac_reporters
                    DiffMergeReporter(),
                    KaleidoscopeReporter()
                    // end-snippet
            )
        #endif
    }
}
