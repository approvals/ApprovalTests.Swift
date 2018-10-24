import XCTest
#if os(OSX)
@testable import ApprovalTests_Swift
#elseif os(iOS)
@testable import ApprovalTests_iOS
#endif

class SampleArrayTest: XCTestCase {
    func testList() throws {
        var names: [String] = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll("", names);
    }
}
