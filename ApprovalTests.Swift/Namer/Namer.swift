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

private struct ClassAndMethod {
    let className: String
    let testName: String

    init(classAndMethod: String) {
        className = Self.extractClassName(classAndMethod)
        testName = Self.extractMethodName(classAndMethod)
    }

    init(className: String, testName: String) {
        self.className = className
        self.testName = testName
    }

    private static func extractClassName(_ classAndMethod: String) -> String {
        String(classAndMethod.split(separator: ".").first!)
    }

    private static func extractMethodName(_ classAndMethod: String) -> String {
        let testNameWithParens = String(classAndMethod.split(separator: ".").last!)
        return String(testNameWithParens.split(separator: "(").first!)
    }
}
