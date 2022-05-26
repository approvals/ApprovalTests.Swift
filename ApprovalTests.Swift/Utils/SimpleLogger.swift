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
    public static var timestamp = true
    public static var printer: (String) -> Void = { print($0, terminator: "") }
    public static var timer: () -> Date = { Date() }
    private static var indent = 0
    private static var hourGlassCount = 0
    private static var hourGlassWrap = 100
    private static var lastDate: Date?

    public static func getIndentation() -> String {
        String(repeating: " ", count: indent * 2)
    }

    public static func logToString() -> StringBuffer {
        timestamp = false
        let buffer = StringBuffer()
        printer = { buffer.append($0) }
        return buffer
    }

    public static func event(_ label: String) {
        log("event: \(label)")
    }

    public static func log(_ s: String) {
        clearHourGlass()
        addTimestamp()
        printer(getIndentation() + s + "\n")
    }

    private static func addTimestamp() {
        if !timestamp { return }
        let time = timer()
        if lastDate == nil {
            lastDate = time
        }
        let difference = Int(1000 * (time.timeIntervalSince1970 - lastDate!.timeIntervalSince1970))
        let formatter = ISO8601DateFormatter()
        let datestamp = "[\(formatter.string(from: time)) ~\(String(format: "%06d", difference))ms] "
        printer(datestamp)
        lastDate = time
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
            addTimestamp()
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
