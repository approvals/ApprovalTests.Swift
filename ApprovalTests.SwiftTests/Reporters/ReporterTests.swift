#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class ReporterTests: XCTestCase {

    func testFirstWorking() throws {
        let reporter1 = TestReporter(success: false)
        let reporter2 = TestReporter(success: true)
        let reporter3 = TestReporter(success: true)

        let success = FirstWorkingReporter(reporter1, reporter2, reporter3).report(received: "r.text", approved: "a.text")

        XCTAssertTrue(success)
        XCTAssertEqual(reporter1.approved, "a.text")
        XCTAssertEqual(reporter2.approved, "a.text")
        XCTAssertEqual(reporter3.approved, "")
    }

    func testMultiReporter() throws {
        let reporter1 = TestReporter(success: true)
        let reporter2 = TestReporter(success: false)
        let reporter3 = TestReporter(success: true)

        let success = ReportWithEverything(reporter1, reporter2, reporter3).report(received: "r.text", approved: "a.text")

        XCTAssertTrue(success)
        XCTAssertEqual(reporter1.approved, "a.text")
        XCTAssertEqual(reporter2.approved, "a.text")
        XCTAssertEqual(reporter3.approved, "a.text")
    }
}
