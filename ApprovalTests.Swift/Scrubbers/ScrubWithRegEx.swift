import Foundation

class ScrubWithRegEx: Scrubber {
    private let pattern: String
    private let replaceWith: String

    public init(pattern: String, replaceWith: String) {
        self.pattern = pattern
        self.replaceWith = replaceWith
    }

    func scrub(_ input: String) -> String {
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let modString = regex.stringByReplacingMatches(in: input, options: [], range: NSRange(location: 0, length:  input.count), withTemplate: replaceWith)
            return modString
        }
        return input
    }
}
