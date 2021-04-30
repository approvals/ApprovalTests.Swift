#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class OptionsTests: XCTestCase {

    func testOptionsGivesTheDefaultReporter() throws {
        let o = Options()
        XCTAssertEqual(Approvals.getReporter() as! EquatableFailureReporter, o.getReporter() as! EquatableFailureReporter)
    }

    func testOptionsHasReporters() throws {
        let reporter = iOSReporter()
        let o1 = Options(reporter: reporter)
        let o2 = Options().withReporter(reporter)
        XCTAssertEqual(reporter, o1.getReporter() as! EquatableFailureReporter)
        XCTAssertEqual(reporter, o2.getReporter() as! EquatableFailureReporter)
    }

    func testMutations() throws {
        let reporter = iOSReporter()
        let scrubber = ScrubDates()
        let options = Options(scrubber).withReporter(reporter)
        let scrubbed: String = try options.scrub("1970-01-01T00:16:40Z")
        XCTAssertEqual(scrubbed, "<date1>")
    }
}
