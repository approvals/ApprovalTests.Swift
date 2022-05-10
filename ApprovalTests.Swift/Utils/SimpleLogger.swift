import Foundation

public class OutMarker {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    deinit {
        SimpleLogger.indent -= 1
        SimpleLogger.printer(SimpleLogger.getIndentation() +  "<- out: " + text)
    }
}

public class StringBuffer: CustomStringConvertible {
    public var description: String {
        "\n" + string
    }

    var string: String = ""
    
    public func append(_ s: String) {
        string += s
    }
}

public enum SimpleLogger {
    static var indent = 0
    
    public static func logToString() -> StringBuffer {
        let output = StringBuffer()
        Self.printer = { s in 
            output.append(s + "\n")
        }
        return output
    }

    public static func variable<T>(_ label: String, _ value: T) {
        Self.printer(getIndentation() + "variable: \(label) = \(String(describing: value))")
    }

    static var printer: (String) -> Void = { w in
        print(w)
    }
    
    public static func useMarkers(_ function: String = #function, file: StaticString = #file, line _: UInt = #line) -> OutMarker {
        let text = function + getFileInfo(file)
        printer(getIndentation() + "-> in: " + text)
        indent += 1
        return OutMarker(text)
    }

    public static func getIndentation() -> String {
        String(repeating: " ", count: indent * 2)
    }

    public static func printLineNumber(_: String = #function, file: StaticString = #file, line: UInt = #line) {
        printer(getIndentation() + "## " + getFileInfo(file) + ":\(line)")
    }

    private static func getFileInfo(_ file: StaticString) -> String {
        let f = "\(file)"
        let fileName = "\((f as NSString).pathComponents.last!)"
        return fileName
    }
}
