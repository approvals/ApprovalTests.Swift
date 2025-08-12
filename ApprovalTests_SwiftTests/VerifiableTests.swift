#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

// begin-snippet: verifiable-example
final class VerifiableTests: XCTestCase {
    func test_verifiable() throws {
        try Approvals.verify(SampleMarkdown())
    }
}

class SampleMarkdown: Verifiable, CustomStringConvertible {
    func getVerifyParameters(_ options: Options) -> VerifyParameters {
        VerifyParameters(options.forFile.with(extensionWithDot: ".md"))
    }

    var description: String {
        """
        | A | B |
        |---|---|
        | 1 | 2 |
        """
    }
}
// end-snippet
