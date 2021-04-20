enum StringUtils {

    public static func padNumber(_ number: Int, _ digits: Int) -> String {
        var text = "\(number)"
        while (text.count < digits) {
            text = "0" + text
        }
        return text
    }

    public static func toString(_ name: String, _ array: [Any]) -> String {
        var buffer = ""
        if (array.isEmpty) {
            buffer.append(name + ".length = 0");
        } else {
            let maxPadding = "\(array.count)".count
            for index in 0 ..< array.count {
                let padding = padNumber(index, maxPadding)
                buffer.append(name + "[" + padding + "] = " + String(describing: array[index]) + "\n")
            }
        }
        return buffer
    }

    static func toJson<T: Encodable>(_ object: T) throws -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        jsonEncoder.outputFormatting = .prettyPrinted
        let jsonData = try jsonEncoder.encode(object)
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
}
