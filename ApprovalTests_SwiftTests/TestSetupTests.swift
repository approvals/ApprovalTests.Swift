#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
#endif

import XCTest

final class TestSetupTests: XCTestCase {
    func test() throws {
      _ = TestSetup()
        XCTAssertTrue(TestSetup.initialized, "Test suite was not initialized")
    }
}
