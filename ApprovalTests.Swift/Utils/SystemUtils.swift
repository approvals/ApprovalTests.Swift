#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

enum SystemUtils {
    static func pasteToClipboard(_ text: String) {
        #if os(iOS)
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        #else
            let pasteboard = NSPasteboard.general
            pasteboard.setString(text, forType: .string)
        #endif
    }
}
