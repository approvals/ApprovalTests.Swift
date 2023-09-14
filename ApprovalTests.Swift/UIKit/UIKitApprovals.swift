#if os(iOS)

    import UIKit

    public enum UIKitApprovals {
        public static func verify(
            view: UIView,
            _ options: Options = Options(),
            file: StaticString = #filePath,
        function: StaticString = #function,
            line: UInt = #line
        ) throws {
            try Approvals.verify(UIWriter(view), options, file: file, function: function, line: line)
        }

        public static func verify(
            viewController: UIViewController,
            _ options: Options = Options(),
            file: StaticString = #filePath,
        function: StaticString = #function,
            line: UInt = #line
        ) throws {
            try verify(view: viewController.view!, options, file: file, function: function, line: line)
        }
    }

#endif
