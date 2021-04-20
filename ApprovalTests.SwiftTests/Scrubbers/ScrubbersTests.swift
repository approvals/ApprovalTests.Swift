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
}
