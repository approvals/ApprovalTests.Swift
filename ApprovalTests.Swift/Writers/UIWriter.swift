#if os(iOS)

    import UIKit

    public class UIWriter: ApprovalWriter {
        private var view: UIView
        private let fileExtensionWithoutDot: String

        public init(_ view: UIView) throws {
            self.view = view
            fileExtensionWithoutDot = "png"
        }

        public func approvalFilename(_ base: String) -> String {
            "\(base).approved.\(fileExtensionWithoutDot)"
        }

        public func receivedFilename(_ base: String) -> String {
            "\(base).received.\(fileExtensionWithoutDot)"
        }

        public func writeReceivedFile(_ received: String) {
            let traitCollection = UITraitCollection()
            let rendererFormat = UIGraphicsImageRendererFormat(for: traitCollection)
            let renderer = UIGraphicsImageRenderer(bounds: view.bounds, format: rendererFormat)
            let data = renderer.pngData { rendererContext in
                view.layer
                    .render(in: rendererContext.cgContext)
            }
            let fileURL = URL(fileURLWithPath: received)
            try! data.write(to: fileURL)
        }
    }

#endif
