#if os(macOS)
    public class ReportWithKaleidoscope: GenericDiffReporter {
        public init() {
            super.init(programPath: "/usr/local/bin/ksdiff")
        }
    }

#endif
