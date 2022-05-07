import ApprovalTests_iOS
@testable import SamplePhoneApp
import XCTest

class ViewControllerTests: XCTestCase {
    func test() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()

        sut.roll()

        XCTAssertNotNil(sut.rollOutputsView.rollResultLabel.text)

//        let options = Options().with(reporter: ReportWithEverything(ReportWithKaleidoscope(), ReportMoveCommandToConsole()))
        try UIKitApprovals.verify(viewController: sut)
    }
}
