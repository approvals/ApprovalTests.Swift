#if os(iOS)
    import UIKit

    enum SystemUtils {
        public static func pasteToClipboard(_ text: String) {
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
    }
#else
    import AppKit

    enum SystemUtils {
        public static func pasteToClipboard(_ text: String) {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            let successful = pasteboard.setString(text, forType: .string)
            if (!successful) {
                print("pasteToClipboard not successful")
            }
        }
    }
#endif
