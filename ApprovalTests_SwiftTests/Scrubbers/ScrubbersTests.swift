#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

final class ScrubbersTests: XCTestCase {
    func testSimpleScrub() throws {
        let randomNumber = Int.random(in: 1 ... 10)
        let s = "\(randomNumber) is a nice number"
        try Approvals.verify(s, Options(ScrubWithRegEx(pattern: "\\d+", replaceWith: "<number>")))
    }

    func testNothingDoesNothing() throws {
        let scrubber = ScrubWithRegEx(pattern: "", replaceWith: "<replacement>")
        XCTAssertEqual(scrubber.scrub("hello"), "hello")
    }

    func testScrubWithClosure() throws {
        let scrubber = ScrubWithRegEx(pattern: "ll", replacementFunction: { match in "\(match.count)" })
        XCTAssertEqual(scrubber.scrub("hello"), "he2o")
    }

    func testScrubbingDates() throws {
        let scrubber = ScrubDates()
        let date = Date(timeIntervalSince1970: 1000)
        let date2 = Date(timeIntervalSince1970: 2000)
        try Approvals.verifyAsJSON(
            TimeSheet(startTime: date, breakTime: date, breakEnd: date2, endOfDay: date2),
            Options(scrubber)
        )
    }

    func test_scrubDates_withoutDates_shouldDoNothing() throws {
        let scrubber = ScrubDates()
        XCTAssertEqual(scrubber.scrub("hello"), "hello")
    }
}

private struct TimeSheet: Codable {
    let startTime: Date
    let breakTime: Date
    let breakEnd: Date
    let endOfDay: Date
}
