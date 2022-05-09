import Foundation

public class OutMarker {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    deinit {
        print("<- out: " + text)
    }
}

public enum SimpleLogger {
    public static func useMarkers(_ function: String = #function, file: StaticString = #file, line _: UInt = #line) -> OutMarker {
        let text = function + getFileInfo(file)
        print("-> in: " + text)
        return OutMarker(text)
    }

    public static func printLineNumber(_: String = #function, file: StaticString = #file, line: UInt = #line) {
        print("## " + getFileInfo(file) + ":\(line)")
    }

    private static func getFileInfo(_ file: StaticString) -> String {
        let f = "\(file)"
        let fileName = "\((f as NSString).pathComponents.last!)"
        return fileName
    }
}
