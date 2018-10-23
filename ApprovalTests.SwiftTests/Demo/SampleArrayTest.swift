import XCTest
@testable import ApprovalTests_Swift

class SampleArrayTest: XCTestCase {
    func testList() throws {
        var names: [String] = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll("", names);
    }
}
