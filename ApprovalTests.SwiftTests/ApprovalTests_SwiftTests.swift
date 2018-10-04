import XCTest
@testable import ApprovalTests_Swift

class ApprovalTests_SwiftTests: XCTestCase {

    func testClassName() {
        let name = Approvals.getNamer()
        XCTAssertEqual("ApprovalTests_SwiftTests.testClassName", name.getApprovalName())
    }

    func testFindReceivedFile() {
        let name = Approvals.getNamer()
        let fileManager = FileManager.default
        let receivedURL = URL(fileURLWithPath: name.getSourceFilePath() + ".received.txt")

        XCTAssertTrue(fileManager.fileExists(atPath: receivedURL.path))
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
