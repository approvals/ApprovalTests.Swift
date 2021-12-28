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

        let success = FirstWorkingReporter(reporter1, reporter2, reporter3)
                .report(received: "r.text", approved: "a.text")

        XCTAssertTrue(success)
        XCTAssertEqual(reporter1.approved, "a.text")
        XCTAssertEqual(reporter2.approved, "a.text")
        XCTAssertEqual(reporter3.approved, "")
    }

    func testMultiReporter() throws {
        let reporter1 = TestReporter(success: true)
        let reporter2 = TestReporter(success: false)
        let reporter3 = TestReporter(success: true)

        let success = ReportWithEverything(reporter1, reporter2, reporter3)
                .report(received: "r.text", approved: "a.text")

        XCTAssertTrue(success)
        XCTAssertEqual(reporter1.approved, "a.text")
        XCTAssertEqual(reporter2.approved, "a.text")
        XCTAssertEqual(reporter3.approved, "a.text")
    }

    #if os(iOS)
        func test_clipboardReporterOnIOS() throws {
            let reporter = ReportMoveCommandToClipboard()

            let success = reporter.report(received: "r.text", approved: "a.text")

            XCTAssertTrue(success)
            let pasteboard = UIPasteboard.general
            let command = pasteboard.string
            XCTAssertEqual(command, "mv r.text a.text")
        }
    #endif

    #if os(OSX)
        func test_clipboardReporterOnMac() throws {
            let reporter = ReportMoveCommandToClipboard()

            let success = reporter.report(received: "r.text", approved: "a.text")

            XCTAssertTrue(success)
            let pasteboard = NSPasteboard.general
            let command = pasteboard.string(forType: .string)
            XCTAssertEqual(command, "mv r.text a.text")
        }
    #endif
        
    #if os(OSX)
        func test_fileLaunchingOnMac() throws {
            let reporter = ReportByOpeningReceivedFile()
            let process = reporter.makeProcess(received: "r.html", approved: "a.html")
            try Approvals.verify("\(process.executableURL!) \(process.arguments!)")
        }
    #endif
}
