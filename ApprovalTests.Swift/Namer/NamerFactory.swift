import Foundation

public class NamerFactory {
    public init() {}

    public static func withParameters(_ parameters: String ...) throws -> Options {
        Options().with(namerCreator: {(filePath: String) -> ApprovalNamer in
            return ParameterizedNamer(filePath, parameters)
        })
    }
}
