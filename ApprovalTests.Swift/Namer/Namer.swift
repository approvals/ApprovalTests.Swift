import Foundation

public class Namer: ApprovalNamer {
    private let fileName: String
    private let functionName: String

    public init(_ file: String, _ function: String) {
        fileName = file
        functionName = function
    }

    public func approvalName() -> String {
        let fullName = sourceFilePath()
        let lastSlashIndex = fullName.lastIndex(of: "/")!
        return String(fullName[fullName.index(after: lastSlashIndex)...])
    }

    public func sourceFilePath() -> String {
        let baseName = (fileName as NSString).deletingPathExtension
        let functionNameWithoutParentheses = functionName.dropLast(2)
        return baseName + "." + "\(functionNameWithoutParentheses)"
    }
}
