public class ReportWithDiffTool: FirstWorkingReporter {
    public init() {
        super.init(
                // begin-snippet: reporters
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
    }
}
