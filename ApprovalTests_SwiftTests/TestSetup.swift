#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import Foundation

// begin-snippet: approvaltests_initialization_class
public class TestSetup: NSObject {
    
    override init() {
        super.init()
        // end-snippet
        TestSetup.initialized = true
        // begin-snippet: register_default_reporter
        disposer = ReporterFactory.registerDefaultReporter {
            ReportWithDiffTool()
        }
        // end-snippet
    }

    private var disposer: DefaultReporterDisposer!

    static var initialized = false
}

//class YourPreferredReporter: ReportWithDiffTool {
//}
