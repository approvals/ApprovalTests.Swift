import XCTest
#if os(OSX)
@testable import ApprovalTests_Swift
#elseif os(iOS)
@testable import ApprovalTests_iOS
#endif

class ApprovalTests_SwiftTests: XCTestCase {

    func testClassName() {
        let name = Approvals.getNamer()
        XCTAssertEqual("ApprovalTests_SwiftTests.testClassName", name.getApprovalName())
    }

    func testApprovalsVerify() {
        try! Approvals.verify("bar")
    }

    func testWithReporter() {
        let reporter = TestReporter()
        do {
            try Approvals.verify("bar", reporter)
        } catch {
        }
        XCTAssertNotEqual("", reporter.received)
    }
}
