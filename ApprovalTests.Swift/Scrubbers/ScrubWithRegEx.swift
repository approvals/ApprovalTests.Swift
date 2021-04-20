import Foundation

class ScrubWithRegEx: Scrubber {
    private let pattern: String
    private let replacementFunction: (String) -> String

    public init(pattern: String, replaceWith: String) {
        self.pattern = pattern
        self.replacementFunction = { _ in replaceWith }
    }

    public init(pattern: String, replacementFunction: @escaping (String) -> String) {
        self.pattern = pattern
        self.replacementFunction = replacementFunction
    }

    func scrub(_ input: String) -> String {
        if pattern == "" { return input }
        return input.replacingOccurrences(matchingPattern: pattern, replacementProvider: replacementFunction)
    }
}

extension String {
    func replacingOccurrences(matchingPattern pattern: String,
                              replacementProvider: (String) -> String?) -> String {
        let expression = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = expression.matches(in: self, options: [], range: NSRange(startIndex ..< endIndex, in: self))
        return matches
                .reversed()
                .reduce(into: self) { (current, result) in
                    let range = Range(result.range, in: current)!
                    let token = String(current[range])
                    guard let replacement = replacementProvider(token) else { return }
                    current.replaceSubrange(range, with: replacement)
                }
    }
}
