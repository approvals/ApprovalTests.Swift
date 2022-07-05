#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

class SampleMarkdown: Verifiable, CustomStringConvertible {
    func getVerifyParameters(_ options: Options) -> VerifyParameters {
        return VerifyParameters(options.forFile.with(extensionWithDot: ".md"))
    }

    public var description: String {
        """
        | A | B |
        |---|---|
        | 1 | 2 |
        """
    }
}

final class VerifiableTests: XCTestCase {
    func test_verifiable() throws {
        try Approvals.verify(SampleMarkdown())
    }
}
