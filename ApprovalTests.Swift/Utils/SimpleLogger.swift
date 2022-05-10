import Foundation

public class OutMarker {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    deinit {
        SimpleLogger.indent -= 1
        SimpleLogger.log("<- out: " + text)
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
    private static var hourGlassWrap: Int = 100
    private static var hourGlassCount: Int = 0

    public static func hourGlass() {
        if (hourGlassWrap <= hourGlassCount)
        {
            clearHourGlass()
        }
        if (hourGlassCount == 0)
        {
            Self.printer(getIndentation())
        }
        hourGlassCount += 1
        let mark: String = ((hourGlassCount % 10) == 0) ? (String(hourGlassCount / 10)) : ".";
        Self.printer(mark)
    }

    public static func logToString() -> StringBuffer {
        let output = StringBuffer()
        Self.printer = { s in 
            output.append(s)
        }
        return output
    }

    public static func variable<T>(_ label: String, _ value: T) {
        Self.log("variable: \(label) = \(String(describing: value))")
    }

    static var printer: (String) -> Void = { w in
        print(w, terminator: "")
    }
    
    public static func log(_ s: String) {
        clearHourGlass()
        Self.printer(Self.getIndentation() + s + "\n")
    }

    private static func clearHourGlass() {
        if hourGlassCount != 0 {
            hourGlassCount = 0
            Self.printer("\n")
        }
    }

    public static func useMarkers(_ function: String = #function, file: StaticString = #file, line _: UInt = #line) -> OutMarker {
        let text = function + getFileInfo(file)
        log("-> in: " + text)
        indent += 1
        return OutMarker(text)
    }

    public static func getIndentation() -> String {
        String(repeating: " ", count: indent * 2)
    }

    public static func printLineNumber(_: String = #function, file: StaticString = #file, line: UInt = #line) {
        log("## " + getFileInfo(file) + ":\(line)")
    }

    private static func getFileInfo(_ file: StaticString) -> String {
        let f = "\(file)"
        let fileName = "\((f as NSString).pathComponents.last!)"
        return fileName
    }
}
