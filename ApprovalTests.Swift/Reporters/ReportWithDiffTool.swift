public class ReportWithDiffTool: FirstWorkingReporter {
    public init() {
        super.init(
                ReportersForiOS(),
                ReportersForMac()
        )
    }
}
