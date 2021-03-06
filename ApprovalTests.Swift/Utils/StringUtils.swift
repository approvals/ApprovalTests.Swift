import Foundation

enum StringUtils {

    public static func endWithNewline(_ text: String) -> String {
        var buffer = text
        if !buffer.hasSuffix("\n") {
            buffer += "\n"
        }
        return buffer
    }

    public static func toString<T>(_ name: String, _ array: [T]) -> String {
        guard !array.isEmpty else {
            return "\(name).length = 0"
        }
        var buffer = ""
        let maxPadding = "\(array.count - 1)".count
        for (index, element) in array.enumerated() {
            buffer += "\(name)[\(padNumber(index, maxPadding))] = \(element)\n"
        }
        return buffer
    }

    private static func padNumber(_ number: Int, _ digits: Int) -> String {
        let text = "\(number)"
        let padding = String(repeating: "0", count: digits - text.count)
        return padding + text
    }

    public static func toJSON<T: Encodable>(_ object: T) throws -> String {
        let jsonEncoder = JSONEncoder()
        if #available(iOS 10.0, *) {
            jsonEncoder.dateEncodingStrategy = .iso8601
        }
        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted.union(.sortedKeys)
        }
        let jsonData = try jsonEncoder.encode(object)
        return String(data: jsonData, encoding: .utf8) ?? ""
    }

    public static func printDictionary<Key: Hashable & Comparable, Value>(_ dictionary: [Key: Value]) throws -> String {
        var buffer = "[\n"
        var keys = Array(dictionary.keys)
        keys.sort()
        for key in keys {
            buffer += "  \(key) : \(dictionary[key]!),\n"
        }
        buffer += "]\n"
        return buffer
    }

    public static func printGrid(_ width: Int,
                                 _ height: Int,
                                 _ cellPrinter: (Int, Int) -> String) -> String {
        var buffer = ""
        for y in 0 ..< height {
            for x in 0 ..< width {
                buffer += cellPrinter(x, y)
            }
            buffer += "\n"
        }
        return buffer
    }
}
