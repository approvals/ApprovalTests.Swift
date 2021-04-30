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
