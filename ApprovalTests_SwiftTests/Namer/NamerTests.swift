@testable import ApprovalTests_Swift
import XCTest

final class NamerTests: XCTestCase {
    func test_parameters() throws {
        try Approvals.verify("# Title\n> Quoted text", Approvals.Namer1.withParameters("story1").forFile.with(extensionWithDot: ".md"))
    }
}
