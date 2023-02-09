#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
#endif
import XCTest

final class ApprovalTests_SwiftTests: XCTestCase {
    func testApprovalName() throws {
      let name = Approvals.makeNamer(forFile: "DUMMY", function: "testApprovalName()")
        XCTAssertEqual(name.approvalName(), "DUMMY.testApprovalName")
    }

    func testSourceFilePath() throws {
      let name = Approvals.makeNamer(forFile: #file, function: "testSourceFilePath()")
        let sourceFilePath = name.sourceFilePath()
        XCTAssertTrue(
            sourceFilePath.hasSuffix(
                "ApprovalTests_SwiftTests/ApprovalTests_SwiftTests.testSourceFilePath"
            ),
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

private class TestFailer: Failer {
    var failed = false

  func fail(_: String, file _: StaticString, function _: StaticString, line _: UInt) throws {
        failed = true
    }
}
