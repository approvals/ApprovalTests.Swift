#if os(iOS)
  import ApprovalTests_iOS
#else
  import ApprovalTests_Swift
#endif
import XCTest

final class ReporterFactoryTests: XCTestCase {
    func testDefaultReporter() throws {
        let reporter1 = ReporterFactory.get
        verifyDefaultReporter(reporter1, match: true)

        do {
            let disposable = ReporterFactory.registerDefaultReporter { TestReporter(success: false) }
            withExtendedLifetime(disposable) {
                verifyDefaultReporter(reporter1, match: false)
            }
        }

        verifyDefaultReporter(reporter1, match: true)
    }

    private func verifyDefaultReporter(
        _ reporter1: ApprovalFailureReporter,
        match: Bool,
        file: StaticString = #filePath,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let reporter3 = ReporterFactory.get
        XCTAssertEqual(reporter1 as? EquatableFailureReporter == reporter3 as? EquatableFailureReporter, match, file: file, line: line)
    }
}
