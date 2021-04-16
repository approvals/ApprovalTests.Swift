enum StringUtils {

    /***********************************************************************/
    public static func padNumber(_ number: Int, _ digits: Int) -> String {
        var text: String = "" + String(number)
        while (text.count < digits) {
            text = "0" + text
        }
        return text
    }

    /***********************************************************************/
    public static func toString(_ name: String, _ array: [Any]) -> String {
        var buffer: String = ""
        if (array.isEmpty)
        {
            buffer.append(name + ".length = 0");
        }
        else
        {
            let maxPadding: Int = (String(array.count).count)
            for index in 0..<array.count {
                let padding = padNumber(index, maxPadding)
                buffer.append(name + "[" + padding + "] = " + String(describing: array[index]) + "\n")
            }
        }
        return buffer
    }
}
