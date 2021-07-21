@testable import ApprovalTests_Swift
import XCTest

final class ReporterFactoryTests: XCTestCase {

    func testDefaultReporter() throws {
        let reporter1 = ReporterFactory.get
        let reporter2 = ReporterFactory.get
        XCTAssertEqual(reporter1 as? EquatableFailureReporter, reporter2 as? EquatableFailureReporter)
        
        for i in 1...1 {
            let disposable = ReporterFactory.registerDefaultReporter({ return TestReporter(success: false) })
            let reporter3 = ReporterFactory.get
            XCTAssertNotEqual(reporter1 as? EquatableFailureReporter, reporter3 as? EquatableFailureReporter)
        }

        let reporter4 = ReporterFactory.get
        XCTAssertEqual(reporter1 as? EquatableFailureReporter, reporter4 as? EquatableFailureReporter)
    }
}
