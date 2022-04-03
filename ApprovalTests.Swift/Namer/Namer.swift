import Foundation

public struct Namer: ApprovalNamer {
    private let fileName: String

    public init(_ file: String) {
        fileName = file
    }

    public func approvalName() -> String {
        let names = StackDemangler().extractNames()
        return names.className + "." + names.testName
    }

    public func sourceFilePath() -> String {
        let names = StackDemangler().extractNames()
        let baseName = (fileName as NSString).deletingPathExtension
        return baseName + "." + names.testName
    }
}

private struct ClassAndMethod {
    let className: String
    let testName: String

    init(classAndMethod: String) {
        className = ClassAndMethod.extractClassName(classAndMethod)
        testName = ClassAndMethod.extractMethodName(classAndMethod)
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

private class StackDemangler {
    private let callStack = Thread.callStackSymbols

    func extractNames() -> ClassAndMethod {
        do {
            let testMethodIndex = findTestMethod()
            let dollarSignIndex = callStack[testMethodIndex].firstIndex(of: "$")!
            let mangledNameAndOffset = callStack[testMethodIndex].suffix(from: dollarSignIndex)
            let firstSpaceIndex = mangledNameAndOffset.firstIndex(of: " ")!
            let mangledName = String(mangledNameAndOffset.prefix(upTo: firstSpaceIndex))
            let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
            let readableDescription = swiftSymbol.print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))
            let readableWords = readableDescription.split(separator: " ")
            return ClassAndMethod(classAndMethod: String(readableWords.last!))
        } catch {
            print("Error in \(#function): \(error)")
            return ClassAndMethod(className: "ERROR", testName: "ERROR")
        }
    }

    private func findTestMethod() -> Int {
        let depth = searchDownForXCTestAssertion()
        return searchUpForTestMethod(from: depth)
    }

    private func searchDownForXCTestAssertion() -> Int {
        var depth = 0
        while depth < callStack.count {
            if isXCTestAssertion(depth) {
                break
            }
            depth += 1
        }
        return depth
    }

    private func searchUpForTestMethod(from depth: Int) -> Int {
        var depth = depth
        while depth > 0 {
            depth -= 1
            if isTestMethod(depth) {
                break
            }
        }
        return depth
    }

    private func isXCTestAssertion(_ depth: Int) -> Bool {
        callStack[depth].contains("XCTest")
    }

    private func isTestMethod(_ depth: Int) -> Bool {
        callStack[depth].contains("test")
    }
}
