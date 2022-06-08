import Foundation

public class NamerFactory {
    public init() {}

    public static func withParameters(_ parameters: String ...) throws -> Options {
        Options().with { (filePath: String) -> ApprovalNamer in
            ParameterizedNamer(filePath, parameters)
        }
    }
}
