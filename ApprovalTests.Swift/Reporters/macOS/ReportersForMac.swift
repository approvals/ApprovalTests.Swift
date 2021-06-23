public class ReportersForMac: FirstWorkingReporter {
public init() {
        #if os(macOS)
            super.init(
                    // begin-snippet: mac_reporters
                    ReportWithBeyondCompare(),
                    ReportWithAppCode(),
                    ReportWithDiffMerge(),
                    ReportWithKaleidoscope(),
                    ReportWithP4Merge(),
                    ReportWithKdiff3(),
                    ReportWithTKDiff(),
                    ReportWithVisualStudioCode()
                    // end-snippet
            )
        #endif
    }
}
