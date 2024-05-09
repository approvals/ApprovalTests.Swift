#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif

import XCTest

final class TestSetupTests: XCTestCase {
    func test() throws {
        XCTAssertTrue(TestSetup.initialized, "Test suite was not initialized")
    }
}
