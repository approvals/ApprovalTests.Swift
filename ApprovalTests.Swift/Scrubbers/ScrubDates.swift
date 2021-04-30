import Foundation

public class ScrubWithRegExWithReplacementAliasing: ScrubWithRegEx {
    public init(pattern: String, aliaser: @escaping (Int) -> String) {
        var hash: [String: Int] = [:]
        super.init(pattern: pattern, replacementFunction: { d in
            var index = hash.count + 1
            if hash[d] == nil {
                hash[d] = index
            }
            index = hash[d]!
            return aliaser(index)
        })
    }
}

public class ScrubDates: ScrubWithRegExWithReplacementAliasing {
    public init() {
        super.init(pattern: "\\d{4}-\\d{1,2}-\\d{1,2}T\\d{1,2}:\\d{2}:\\d{2}Z", aliaser: { index in
            return "<date\(index)>"
        })
    }
}
