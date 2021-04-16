#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class OptionsTests: XCTestCase {

    func test_optionsGivesTheDefaultReporter() throws {
        let o = Options()
        XCTAssertEqual(Approvals.getReporter() as! EquatableFailureReporter, o.getReporter() as! EquatableFailureReporter)
    }
}
