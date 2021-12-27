#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class OptionsTests: XCTestCase {

    func testOptionsGivesTheDefaultReporter() throws {
        let o = Options()
        XCTAssertEqual(o.reporter as? EquatableFailureReporter, Approvals.reporter as? EquatableFailureReporter)
    }

    func testOptionsHasReporters() throws {
        let reporter = ReportWithDiffTool()
        let o1 = Options(reporter)
        let o2 = Options().withReporter(reporter)
        XCTAssertEqual(o1.reporter as? EquatableFailureReporter, reporter)
        XCTAssertEqual(o2.reporter as? EquatableFailureReporter, reporter)
    }

    func test_optionsHasScrubbers() throws {
        let scrubber = ScrubDates()
        let o1 = Options(scrubber)
        let o2 = Options().withScrubber(scrubber)
        XCTAssertIdentical(o1.scrubber, scrubber)
        XCTAssertIdentical(o2.scrubber, scrubber)
    }

    func testMutations() throws {
        let reporter = ReportWithDiffTool()
        let scrubber = ScrubDates()
        let options = Options(scrubber).withReporter(reporter)
        let scrubbed: String = try options.scrub("1970-01-01T00:16:40Z")
        XCTAssertEqual(scrubbed, "<date1>")
    }

    func testFileExtension() throws {
        var options = Options()
        XCTAssertEqual(options.forFile.fileExtensionWithDot, ".txt")
        options = options.forFile.withExtension(".json")
        XCTAssertEqual(options.forFile.fileExtensionWithDot, ".json")
        XCTAssertEqual(options.forFile.fileExtensionWithoutDot, "json")
    }

}
