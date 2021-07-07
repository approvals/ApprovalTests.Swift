@testable import ApprovalTests_Swift
import XCTest

final class TestSetupTests: XCTestCase {

    func test() throws {
        XCTAssertTrue(TestSetup.initialized, "Test suite was not initialized")
    }
}
