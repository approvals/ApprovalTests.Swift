import Foundation

public class ScrubDates: ScrubWithRegEx {
    public init() {
        var hash: [String: Int] = [:]
        super.init(pattern: "\\d{4}-\\d{1,2}-\\d{1,2}T\\d{1,2}:\\d{2}:\\d{2}Z", replacementFunction: { d in
            var index = hash.count + 1
            if hash[d] == nil {
                hash[d] = index
            }
            index = hash[d]!
            return "<date\(index)>"
        })
    }
}
