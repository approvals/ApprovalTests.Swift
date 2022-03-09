import Foundation

public enum StringUtils {

    /// Ends text with newline, unless it already ends with newline.
    public static func endWithNewline(_ text: String) -> String {
        var buffer = text
        if !buffer.hasSuffix("\n") {
            buffer += "\n"
        }
        return buffer
    }

    /**
     Converts array of items to string.
     
     Each element of the array is on a separate line, preceded by the name and its array index.
     
     - Parameters:
       - array: Array to print to string. 
       - name: Name of the array, to describe each element as `name[i] = value`.
     */
    public static func toString<T>(_ header: String = "",
                                   _ array: [T],
                                   _ labeler: ((T) -> String)? = nil,
                                   label: String = ""
    ) -> String {
        guard !array.isEmpty else {
            let name = label.isEmpty ? "array" : label
            return "\(name).length = 0"
        }
        var buffer = ""
        var labeler_ = labeler
        if labeler_ == nil || !label.isEmpty {
            var count = 0
            let maxPadding = "\(array.count - 1)".count
            labeler_ = { element in
                count += 1
                return "\(label)[\(pad(number: count - 1, digits: maxPadding))] = \(element)"
            }
        }
        if !header.isEmpty {
            buffer += header + "\n\n"
        }
        for element in array {
            buffer += labeler_!(element) + "\n"
        }
        return buffer
    }

    private static func pad(number: Int, digits: Int) -> String {
        let text = "\(number)"
        let padding = String(repeating: "0", count: digits - text.count)
        return padding + text
    }

    /// Converts object to JSON, sorted by key. Dates are converted to ISO8601.
    public static func toJSON<T: Encodable>(_ object: T) throws -> String {
        let jsonEncoder = JSONEncoder()
        if #available(iOS 10.0, *) {
            jsonEncoder.dateEncodingStrategy = .iso8601
        }
        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted.union(.sortedKeys)
        }
        let jsonData = try jsonEncoder.encode(object)
        return String(decoding: jsonData, as: UTF8.self)
    }

    /// Prints dictionary sorted by key, returning it as a string.
    public static func printDictionary<Key: Hashable & Comparable, Value>(_ dictionary: [Key: Value]) -> String {
        var buffer = "[\n"
        var keys = Array(dictionary.keys)
        keys.sort()
        for key in keys {
            buffer += "  \(key) : \(dictionary[key]!),\n"
        }
        buffer += "]\n"
        return buffer
    }

    /**
     Prints grid of information, returning it as a string.
     
     - Parameters:
       - width: Width of grid. 
       - height: Height of grid.
       - cellPrinter: Converts (x, y) coordinates into output. The first grid point is (0, 0).
     */
    public static func printGrid(width: Int, height: Int, cellPrinter: (Int, Int) -> String) -> String {
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
