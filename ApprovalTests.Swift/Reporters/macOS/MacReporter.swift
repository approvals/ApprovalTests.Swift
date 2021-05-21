class MacReporter: FirstWorkingReporter {
    init() {
        #if os(macOS)
            super.init(
                    // begin-snippet: mac_reporters
                    ReportWithBeyondCompare(),
                    ReportWithAppCode(),
                    DiffMergeReporter(),
                    KaleidoscopeReporter(),
                    ReportWithP4Merge(),
                    ReportWithKdiff3(),
                    ReportWithTKDiff(),
                    ReportWithVisualStudioCode()
                    // end-snippet
            )
        #endif
    }
}
