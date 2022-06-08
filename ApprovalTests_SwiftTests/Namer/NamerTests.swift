#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

final class NamerTests: XCTestCase {
    func test_parameters() throws {
        try Approvals.verify("# Title\n> Quoted text", Approvals.Names.withParameters("story1").forFile.with(extensionWithDot: ".md"))
    }
}
