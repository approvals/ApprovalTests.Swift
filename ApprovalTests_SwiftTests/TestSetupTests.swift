#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif

import XCTest

final class TestSetupTests: XCTestCase {

    func test() throws {
        XCTAssertTrue(TestSetup.initialized, "Test suite was not initialized")
    }
}
