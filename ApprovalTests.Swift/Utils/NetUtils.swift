import Foundation

public enum NetUtils {
    public static func readURL(_ url: String) -> String {
        try! String(contentsOf: URL(string: url)!)
    }
}
