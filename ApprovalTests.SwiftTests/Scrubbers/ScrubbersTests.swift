#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class ScrubbersTests: XCTestCase {

    func testSimpleScrub() throws {
        let randomNumber = Int.random(in: 1...10)
        let s = "\(randomNumber) is a nice number"
        try Approvals.verify(s, Options(ScrubWithRegEx(pattern: "\\d+", replaceWith: "<number>")))
    }

    func testNothingDoesNothing() throws {
        let scrubber = ScrubWithRegEx(pattern: "", replaceWith: "<replacement>")
        XCTAssertEqual(scrubber.scrub("hello"), "hello")
    }

    func testScrubWithClosure() throws {
        let scrubber = ScrubWithRegEx(pattern: "ll", replacementFunction: { match in "\(match.count)" } )
        XCTAssertEqual(scrubber.scrub("hello"), "he2o")
    }
}
