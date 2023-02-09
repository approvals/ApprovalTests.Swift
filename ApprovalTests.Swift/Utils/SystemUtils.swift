#if os(iOS)
    import UIKit

    public enum SystemUtils {
        public static func pasteToClipboard(_ text: String) {
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
    }
#elseif os(macOS)
    import AppKit

    public enum SystemUtils {
        public static func pasteToClipboard(_ text: String) {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([.string], owner: nil)
            let successful = pasteboard.setString(text, forType: .string)
            if !successful {
                print("pasteToClipboard not successful")
            }
        }
    }
#else
public enum SystemUtils {
  public static func pasteToClipboard(_ text: String) {
  }
}
#endif
