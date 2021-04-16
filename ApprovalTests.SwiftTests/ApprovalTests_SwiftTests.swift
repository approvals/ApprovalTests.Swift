import XCTest
#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif

final class ApprovalTests_SwiftTests: XCTestCase {

    func testClassName() throws {
        let name = Approvals.getNamer()
        XCTAssertEqual("ApprovalTests_SwiftTests.testClassName", name.getApprovalName())
    }

    func testApprovalsVerify() throws {
        try! Approvals.verify("bar")
    }

    func testWithReporter() throws {
        let reporter = TestReporter(success: true)
        let failer: TestFailer = TestFailer()
        FileApprover.registerFailer(failer)
        try Approvals.verify("bar", reporter)
        FileApprover.resetFailer()
        XCTAssertNotEqual("", reporter.received)
        XCTAssertTrue(failer.failed)
    }
}

class TestFailer: Failer {
    var failed = false

    func fail(_ message: String) throws {
        failed = true
    }
}
