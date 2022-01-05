@testable import SamplePhoneApp
import XCTest

class ViewControllerTests: XCTestCase {

    func test() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()

        sut.roll()
        
        XCTAssertNotNil(sut.rollOutputsView.rollResultLabel.text)

        let myView = sut.view!
        UIGraphicsBeginImageContextWithOptions(myView.layer.frame.size, false, 3.0)
        myView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        if let data = viewImage.pngData() {
            let filename = URL(fileURLWithPath: "/tmp/image.png")
            try data.write(to: filename)
        }
    }
}
