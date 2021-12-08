import Foundation

public func readURL(_ url: String) -> String {
    try! String(contentsOf: URL(string: url)!)
}
