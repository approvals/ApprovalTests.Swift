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
            pasteboard.setString(text, forType: .string)
        }
    }
#endif
