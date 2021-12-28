#if os(macOS)

    import Foundation

    /**
     A reporter that opens the received file if it differs from the approved file.
     */
    public class ReportByOpeningReceivedFile: GenericDiffReporter {
        public init() {
            super.init(programPath: "/usr/bin/open", arguments: { received, approved in [received] })
        }
    }

#endif
