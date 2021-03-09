import Foundation

class ReporterFactory {
    let FRONTLOADED_REPORTER = "FrontloadedReporter"
    let USE_REPORTER         = "UseReporter";

    public static func get() -> ApprovalFailureReporter {
        #if os(OSX)
        let returned = DiffMergeReporter()
        #elseif os(iOS)
        let returned = XCTReporter()
        #endif
        return returned
    }
}
