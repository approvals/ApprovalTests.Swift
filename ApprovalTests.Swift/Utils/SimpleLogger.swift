import Foundation

public class OutMarker {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    deinit {
        SimpleLogger.markerOut(text)
    }
}

public class StringBuffer: CustomStringConvertible {
    private var string = ""

    public var description: String {
        "\n" + string
    }

    public func append(_ s: String) {
        string += s
    }
}

public enum SimpleLogger {
    public static var printer: (String) -> Void = { print($0, terminator: "") }
    private static var indent = 0
    private static var hourGlassCount = 0
    private static var hourGlassWrap = 100

    public static func getIndentation() -> String {
        String(repeating: " ", count: indent * 2)
    }

    public static func logToString() -> StringBuffer {
        let buffer = StringBuffer()
        printer = { buffer.append($0) }
        return buffer
    }

    public static func log(_ s: String) {
        clearHourGlass()
        printer(getIndentation() + s + "\n")
    }

    public static func printLineNumber(file: StaticString = #file, line: UInt = #line) {
        log("## " + getFileInfo(file) + ":\(line)")
    }

    public static func useMarkers(_ function: String = #function, file: StaticString = #file, line _: UInt = #line) -> OutMarker {
        let text = function + getFileInfo(file)
        log("-> in: " + text)
        indent += 1
        return OutMarker(text)
    }

    public static func variable<T>(_ label: String, _ value: T) {
        log("variable: \(label) = \(String(describing: value))")
    }

    public static func hourGlass() {
        if hourGlassWrap <= hourGlassCount {
            clearHourGlass()
        }
        if hourGlassCount == 0 {
            printer(getIndentation())
        }
        hourGlassCount += 1
        let mark = hourGlassCount.isMultiple(of: 10) ? String(hourGlassCount / 10) : "."
        printer(mark)
    }

    private static func clearHourGlass() {
        if hourGlassCount != 0 {
            hourGlassCount = 0
            printer("\n")
        }
    }

    private static func getFileInfo(_ file: StaticString) -> String {
        let f = "\(file)"
        let fileName = "\((f as NSString).pathComponents.last!)"
        return fileName
    }

    fileprivate static func markerOut(_ text: String) {
        indent -= 1
        log("<- out: " + text)
    }
}
