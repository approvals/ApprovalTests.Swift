#if os(macOS)

    class ReportWithKaleidoscope: GenericDiffReporter {
        init() {
            super.init(programPath: "/usr/local/bin/ksdiff")
        }
    }

#endif
