import XCTest
@testable import ApprovalTests_Swift

class ApprovalsTest: XCTestCase {
    func testToString() throws {
        try Approvals.verify(CGRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testAsJson() throws {
        try Approvals.verifyAsJson(CGRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testAsJsonWithCustomObject() throws {
        try Approvals.verifyAsJson(MyRect(x: 5, y: 10, width: 100, height: 200))
    }
}

class MyRect: Codable {
    var x: Int
    var y: Int
    var width: Int
    var height: Int

    init(x x: Int, y y: Int, width width: Int, height height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}