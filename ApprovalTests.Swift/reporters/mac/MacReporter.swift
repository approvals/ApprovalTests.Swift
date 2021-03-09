import Foundation

class MacReporter: FirstWorkingReporter {
    init() {
        super.init(DiffMergeReporter())
    }
}
