class ReportWithDiffTool: FirstWorkingReporter {
    init() {
        super.init(
                ReportersForiOS(),
                ReportersForMac()
        )
    }
}
