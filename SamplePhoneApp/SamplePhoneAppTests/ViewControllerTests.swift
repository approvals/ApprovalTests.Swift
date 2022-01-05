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
        let traitCollection = UITraitCollection()
        let rendererFormat = UIGraphicsImageRendererFormat(for: traitCollection)
        let renderer = UIGraphicsImageRenderer(bounds: myView.bounds, format: rendererFormat)
        let data = renderer.pngData { rendererContext in
            myView.layer.render(in: rendererContext.cgContext)
        }
        let fileURL = URL(fileURLWithPath: "/tmp/image.png")
        try data.write(to: fileURL)
    }
}
