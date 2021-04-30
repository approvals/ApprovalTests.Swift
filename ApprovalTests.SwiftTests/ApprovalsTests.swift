#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class ApprovalsTests: XCTestCase {

    func testToString() throws {
        try Approvals.verify(CGRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testAsJson() throws {
        try Approvals.verifyAsJson(CGRect(x: 5, y: 10, width: 100, height: 200), Options(DiffMergeReporter()))
    }

    func testAsJsonWithCustomObject() throws {
        try Approvals.verifyAsJson(MyRect(x: 5, y: 10, width: 100, height: 200), Options(DiffMergeReporter()))
    }
}

private struct MyRect: Codable {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}
