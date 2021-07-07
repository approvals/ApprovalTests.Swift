#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif

public class TestSetup: NSObject {
    static var initialized = false
    
    override init() {
        super.init()
        TestSetup.initialized = true
        // 
    }
}
