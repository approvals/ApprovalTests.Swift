#if os(macOS)

    import Foundation

    /**
     A reporter that attempts to open the received file using the system default file viewer.

     Depending on the file viewer being launched, the test suite execution may halt until the user has closed the new process.
     */
    public class ReportByOpeningReceivedFile: GenericDiffReporter {
        public init() {
            super.init(programPath: "/usr/bin/open", arguments: { received, _ in [received] })
        }
    }

#endif
