import Foundation

class MacReporter: FirstWorkingReporter {
    init() {
        super.init(KaleidoscopeReporter(), DiffMergeReporter())
    }
}
