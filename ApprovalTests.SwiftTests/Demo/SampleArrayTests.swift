#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

final class SampleArrayTests: XCTestCase {

    func testList() throws {
        var names = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll(label: "", names)
    }
}
