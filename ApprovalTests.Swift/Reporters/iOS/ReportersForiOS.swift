public class ReportersForiOS: FirstWorkingReporter {
    public init() {
        #if os(iOS)
            super.init(
                    // begin-snippet: ios_reporters
                    ReportWithBeyondCompare(),
                    ReportWithAppCode(),
                    ReportWithDiffMerge(),
                    ReportWithKaleidoscope(),
                    ReportWithP4Merge(),
                    ReportWithKdiff3(),
                    ReportWithTKDiff(),
                    ReportWithVisualStudioCode(),
                    ReportContentsWithXCTest()
                    // end-snippet
            )
        #endif
    }
}
