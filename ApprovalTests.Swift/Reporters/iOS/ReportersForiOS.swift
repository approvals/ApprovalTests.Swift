public class ReportersForiOS: FirstWorkingReporter {
    init() {
        #if os(iOS)
            super.init(
                    // begin-snippet: ios_reporters
                    ReportContentsWithXCTest()
                    // end-snippet
            )
        #endif
    }
}
