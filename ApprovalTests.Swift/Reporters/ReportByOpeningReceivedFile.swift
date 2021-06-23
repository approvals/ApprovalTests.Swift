import Foundation

public class ReportByOpeningReceivedFile: GenericDiffReporter {
    init() {
        super.init(programPath: "/usr/bin/open", arguments: { received, approved in [received] })
    }
}
