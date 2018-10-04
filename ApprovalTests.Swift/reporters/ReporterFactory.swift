import Foundation

class ReporterFactory {
    let FRONTLOADED_REPORTER = "FrontloadedReporter"
    let USE_REPORTER         = "UseReporter";

    public static func get() -> ApprovalFailureReporter {
        let returned = DiffMergReporter()
        return returned
    }
}
