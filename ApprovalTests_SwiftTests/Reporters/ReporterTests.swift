#if os(macOS)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
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
        func test_nameWithSpaces() throws {
            let output = GenericDiffReporter.createCommandLine("/path with spaces/r.text", "/path with spaces/a.text", {
                received,
                approved in
                [received, approved]
            }, "diff")
            try Approvals.verify(output)
        }

        func test_nameWithoutSpaces() throws {
            let output = GenericDiffReporter.createCommandLine("/path_without_spaces/r.text", "/path_without_spaces/a.text", {
                received,
                approved in
                [received, approved]
            }, "diff")
            try Approvals.verify(output)
        }
    #endif

    #if os(macOS)
        func test_clipboardReporterOnMac() throws {
            let reporter = ReportMoveCommandToClipboard()

            let success = reporter.report(received: "/path with spaces/r.text", approved: "/path with spaces/a.text")

            XCTAssertTrue(success)
            let pasteboard = NSPasteboard.general
            let command = pasteboard.string(forType: .string)
            XCTAssertEqual(command, "mv \"/path with spaces/r.text\" \"/path with spaces/a.text\"")
        }
    #endif

    #if os(macOS)
        func test_fileLaunchingOnMac() throws {
            let reporter = ReportByOpeningReceivedFile()
            let process = reporter.makeProcess(received: "r.html", approved: "a.html")
            try Approvals.verify("\(process.executableURL!) \(process.arguments!)")
        }
    #endif
}
