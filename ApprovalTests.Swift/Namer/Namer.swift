import Foundation

struct Namer: ApprovalNamer {
    private let fromFile: String

    init(_ file: String) {
        fromFile = file
    }

    func approvalName() -> String {
        let stack = StackDemangler().extractNames()
        return stack.className + "." + stack.testName
    }

    func sourceFilePath() -> String {
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
            let symbols = Thread.callStackSymbols
            let testDepth = selectElement(symbols: symbols)
            let index = symbols[testDepth].range(of: "$")?.lowerBound
            let tempName = String(symbols[testDepth].suffix(from: index!))
            let indexEnd = tempName.range(of: " ")?.lowerBound
            let mangledName = String(tempName.prefix(upTo: indexEnd!))
            let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
            let result = swiftSymbol.print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))
            let splitResult = result.split(separator: " ")
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

    private func selectElement(symbols trace: [String]) -> Int {
        var depth = 0
        for element in trace {
            if isTestCase(element) {
                break
            }
            depth += 1
        }
        return depth - 3
    }

    private func isTestCase(_ element: String) -> Bool {
        element.range(of: "XCTest", options: .caseInsensitive) != nil
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
