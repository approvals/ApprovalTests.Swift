@testable import SamplePhoneApp
import ApprovalTests_iOS
import XCTest


class ViewControllerTests: XCTestCase {

    func test() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()

        sut.roll()
        
        XCTAssertNotNil(sut.rollOutputsView.rollResultLabel.text)

        let myView = sut.view!
        try UIKitApprovals.verify(view: myView, Options().with(reporter: ReportWithEverything(ReportWithKaleidoscope(), ReportMoveCommandToConsole())))
    }
}
