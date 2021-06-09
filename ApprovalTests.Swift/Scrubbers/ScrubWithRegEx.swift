import Foundation

public class ScrubWithRegEx: Scrubber {
    private let pattern: String
    private let replacementFunction: (String) -> String

    public init(pattern: String, replaceWith: String) {
        self.pattern = pattern
        replacementFunction = { _ in replaceWith }
    }

    public init(pattern: String, replacementFunction: @escaping (String) -> String) {
        self.pattern = pattern
        self.replacementFunction = replacementFunction
    }

    public func scrub(_ input: String) -> String {
        if pattern == "" { return input }
        return input.replacingOccurrences(matchingPattern: pattern, replacementProvider: replacementFunction)
    }
}

extension String {
    func replacingOccurrences(matchingPattern pattern: String,
                              replacementProvider: (String) -> String?) -> String {
        let expression = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = expression.matches(in: self, options: [], range: NSRange(startIndex ..< endIndex, in: self))
        guard matches.count > 0 else { return self }
        var splitStart = startIndex
        return matches.map { (match) -> (String, [String]) in
                          let range = Range(match.range, in: self)!
                          let split = String(self[splitStart ..< range.lowerBound])
                          splitStart = range.upperBound
                          return (split, (0 ..< match.numberOfRanges)
                                  .compactMap { Range(match.range(at: $0), in: self) }
                                  .map { String(self[$0]) }
                          )
                      }
                      .reduce("") { "\($0)\($1.0)\(replacementProvider($1.1.first ?? "") ?? "")" }
                + self[Range(matches.last!.range, in: self)!.upperBound ..< endIndex]
    }
}
