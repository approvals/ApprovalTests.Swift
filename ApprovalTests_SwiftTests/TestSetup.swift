#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
#endif
import Foundation
// begin-snippet: approvaltests_initialization_class
public class TestSetup: NSObject {
  override init() {
    super.init()
    // end-snippet
    Self.initialized = true
    // begin-snippet: register_default_reporter
    disposer = ReporterFactory.registerDefaultReporter {
      ReportWithDiffTool()
    }
    // end-snippet
  }

  private var disposer: DefaultReporterDisposer!

  static var initialized = false
}

// class YourPreferredReporter: ReportWithDiffTool {
// }
