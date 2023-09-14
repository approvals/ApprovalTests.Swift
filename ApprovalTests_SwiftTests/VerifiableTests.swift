#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
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

    public var description: String {
        """
        | A | B |
        |---|---|
        | 1 | 2 |
        """
    }
}
// end-snippet
