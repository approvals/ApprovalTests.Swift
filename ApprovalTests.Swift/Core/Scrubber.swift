public protocol Scrubber: AnyObject {
    func scrub(_ input: String) -> String
}
