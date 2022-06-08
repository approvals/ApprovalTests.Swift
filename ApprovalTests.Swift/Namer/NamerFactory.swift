import Foundation

public enum NamerFactory {
    public static func withParameters(_ parameters: String ...) throws -> Options {
        Options().with { (filePath: String) -> ApprovalNamer in
            ParameterizedNamer(filePath, parameters)
        }
    }
}
