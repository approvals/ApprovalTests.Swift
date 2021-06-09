#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class ApprovalTests_SwiftTests: XCTestCase {

    func testApprovalName() throws {
        let name = Approvals.getNamer()
        XCTAssertEqual(name.approvalName(), "ApprovalTests_SwiftTests.testApprovalName")
    }

    func testSourceFilePath() throws {
        let name = Approvals.getNamer()
        let sourceFilePath = name.sourceFilePath()
        XCTAssertTrue(
                sourceFilePath.hasSuffix("/ApprovalTests.Swift/ApprovalTests.SwiftTests/ApprovalTests_SwiftTests.testSourceFilePath"),
                "was \(sourceFilePath)"
        )
    }

    func testApprovalsVerify() throws {
        try Approvals.verify("bar")
    }

    func testWithReporter() throws {
        let reporter = TestReporter(success: true)
        let failer = TestFailer()
        FileApprover.registerFailer(failer)
        try Approvals.verify("bar", Options(reporter))
        FileApprover.resetFailer()
        XCTAssertNotEqual(reporter.received, "")
        XCTAssertTrue(failer.failed)
    }
}

class TestFailer: Failer {
    var failed = false

    func fail(_ message: String, file: StaticString, line: UInt) throws {
        failed = true
    }
}
