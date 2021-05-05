import Foundation

enum SystemUtils {
        static func pasteToClipboard(_ text: String) {
            #if os(iOS)
                let pasteboard = UIPasteboard.general
                pasteboard.string = text
            #else
                let pasteboard = NSPasteboard.general
                pasteboard.string = text
            #endif
        }
}
