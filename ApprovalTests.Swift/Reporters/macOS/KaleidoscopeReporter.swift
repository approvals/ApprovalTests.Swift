#if os(macOS)

    class KaleidoscopeReporter: GenericDiffReporter {
        init() {
            super.init(programPath: "/usr/local/bin/ksdiff")
        }
    }

#endif
