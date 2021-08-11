import Foundation

public func readURL(_ url: String) -> String {
    return try! String(contentsOf: URL(string: url)!)
}
