/**
 ReportWithDiffTool goes through a chain of possible diffing tools to find the first one installed on your system.
 
 If none are found, it falls back to writing the diffs to XCTest.
 
 ReportWithDiffTool is the default Reporter.
 */
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
