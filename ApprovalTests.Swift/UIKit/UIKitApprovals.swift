#if os(iOS)

    import UIKit

    public enum UIKitApprovals {


        public static func verify(view: UIView,
                                  _ options: Options = Options(),
                                  file: StaticString = #filePath,
                                  line: UInt = #line) throws {
            try Approvals.verify(UIWriter(view), options, file: file, line: line)
        }

    }

#endif
