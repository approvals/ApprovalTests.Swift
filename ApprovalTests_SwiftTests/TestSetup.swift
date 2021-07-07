#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif

// begin-snippet: approvaltests_initialization_class
public class TestSetup: NSObject {

    override init() {
        super.init()
        // end-snippet
        TestSetup.initialized = true
    }
    
    static var initialized = false
}
