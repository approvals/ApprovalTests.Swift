import Foundation

class MacReporter: FirstWorkingReporter {
    init() {
        super.init(
                // begin-snippet: mac_reporters
                KaleidoscopeReporter(),
                DiffMergeReporter()
                // end-snippet
        )
    }
}
