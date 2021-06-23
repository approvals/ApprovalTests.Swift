public class ReportersForiOS: FirstWorkingReporter {
public init() {
        #if os(iOS)
            super.init(
                    // begin-snippet: ios_reporters
                    ReportContentsWithXCTest()
                    // end-snippet
            )
        #endif
    }
}
