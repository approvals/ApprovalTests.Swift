import XCTest
#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif

final class SampleArrayTests: XCTestCase {

    func testList() throws {
        var names: [String] = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll("", names);
    }
}