import Foundation

public struct Namer: ApprovalNamer {
    private let fromFile: String

    public init(_ file: String) {
        fromFile = file
    }

    public func approvalName() -> String {
        let stack = StackDemangler().extractNames()
        return stack.className + "." + stack.testName
    }

    public func sourceFilePath() -> String {
        let stack = StackDemangler().extractNames()
        let fileExtension = fromFile.range(of: ".swift")!.lowerBound
        let baseName = fromFile.prefix(upTo: fileExtension)
        return baseName + "." + stack.testName
    }
}

private struct StackNames {
    let className: String
    let testName: String
}

private struct StackDemangler {
    func extractNames() -> StackNames {
        do {
            let callStack = Thread.callStackSymbols
            let testMethodDepth = selectElement(callStack)
            let dollarSignIndex = callStack[testMethodDepth].range(of: "$")?.lowerBound
            let mangledNameAndOffset = String(callStack[testMethodDepth].suffix(from: dollarSignIndex!))
            let firstSpaceIndex = mangledNameAndOffset.range(of: " ")?.lowerBound
            let mangledName = String(mangledNameAndOffset.prefix(upTo: firstSpaceIndex!))
            let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
            let unmangledDescription = swiftSymbol.print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))
            let splitResult = unmangledDescription.split(separator: " ")
            let classAndMethod = splitResult.last!
            return StackNames(
                    className: extractClassName(classAndMethod),
                    testName: extractTestName(classAndMethod)
            )
        } catch {
            print("Error in \(#function): \(error)")
            return StackNames(className: "ERROR", testName: "ERROR")
        }
    }

    private func selectElement(_ symbols: [String]) -> Int {
        var depth = 0
        for element in symbols {
            if isXCTestAssertion(element) {
                break
            }
            depth += 1
        }
        while depth > 0 {
            depth -= 1
            if isTestMethod(symbols[depth]) {
                return depth
            }
        }
        return depth
    }

    private func isXCTestAssertion(_ element: String) -> Bool {
        element.contains("XCTest")
    }

    private func isTestMethod(_ element: String) -> Bool {
        element.contains("test")
    }

    private func extractClassName(_ classAndMethod: String.SubSequence) -> String {
        let className = classAndMethod.prefix(upTo: (classAndMethod.range(of: ".")?.lowerBound)!)
        return String(className)
    }

    private func extractTestName(_ classAndMethod: String.SubSequence) -> String {
        let testNameWithParens = classAndMethod.suffix(from: (classAndMethod.range(of: ".")?.upperBound)!)
        let testName = testNameWithParens.prefix(upTo: (testNameWithParens.range(of: "(")?.lowerBound)!)
        return String(testName)
    }
}
