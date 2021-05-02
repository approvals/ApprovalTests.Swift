import Foundation

enum StringUtils {

    public static func toString(_ name: String, _ array: [Any]) -> String {
        var buffer = ""
        if (array.isEmpty) {
            buffer.append(name + ".length = 0")
        } else {
            let maxPadding = "\(array.count - 1)".count
            for index in 0 ..< array.count {
                let padding = padNumber(index, maxPadding)
                buffer.append(name + "[" + padding + "] = " + String(describing: array[index]) + "\n")
            }
        }
        return buffer
    }

    private static func padNumber(_ number: Int, _ digits: Int) -> String {
        let text = "\(number)"
        let padding = String(repeating: "0", count: digits - text.count)
        return padding + text
    }

    static func toJSON<T: Encodable>(_ object: T) throws -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted.union(.sortedKeys)
        let jsonData = try jsonEncoder.encode(object)
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
}
