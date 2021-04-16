import Foundation

class MacReporter: FirstWorkingReporter {
    init() {
        #if os(macOS)
            super.init(
                    // begin-snippet: mac_reporters
                    KaleidoscopeReporter(),
                    DiffMergeReporter()
                    // end-snippet
            )
        #endif
    }
}
