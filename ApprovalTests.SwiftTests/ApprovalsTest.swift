import XCTest
@testable import ApprovalTests_Swift

class ApprovalsTest: XCTestCase {
    func testToString() throws {
        try Approvals.verify(CGRect(x: 5, y: 10, width: 100, height: 200))
    }
}
