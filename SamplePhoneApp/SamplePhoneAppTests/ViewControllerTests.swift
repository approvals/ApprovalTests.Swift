@testable import SamplePhoneApp
import ApprovalTests_iOS
import UIKit
import XCTest


class UIWriter: ApprovalWriter {
    private var view: UIView
    private let fileExtensionWithoutDot: String

    init(_ view: UIView) throws {
        self.view = view
        fileExtensionWithoutDot = "png"
    }

    public func approvalFilename(_ base: String) -> String {
        "\(base).approved.\(fileExtensionWithoutDot)"
    }

    public func receivedFilename(_ base: String) -> String {
        "\(base).received.\(fileExtensionWithoutDot)"
    }

    func writeReceivedFile(_ received: String) {
        let traitCollection = UITraitCollection()
        let rendererFormat = UIGraphicsImageRendererFormat(for: traitCollection)
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: rendererFormat)
        let data = renderer.pngData { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
        let fileURL = URL(fileURLWithPath: received)
        try! data.write(to: fileURL)
    }
}

class ViewControllerTests: XCTestCase {

    func test() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()

        sut.roll()
        
        XCTAssertNotNil(sut.rollOutputsView.rollResultLabel.text)

        let myView = sut.view!
        try verify(view: myView)
    }

    private func verify(view: UIView, _ options: Options = Options(), file: StaticString = #filePath, line: UInt = #line) throws {
        let traitCollection = UITraitCollection()
        let rendererFormat = UIGraphicsImageRendererFormat(for: traitCollection)
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: rendererFormat)
        let data = renderer.pngData { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
        let fileURL = URL(fileURLWithPath: "/tmp/image.png")
        try data.write(to: fileURL)

        try Approvals.verify(UIWriter(view), options, file: file, line: line)
    }
}
