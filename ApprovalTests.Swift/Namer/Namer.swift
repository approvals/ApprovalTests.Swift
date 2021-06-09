import Foundation

class Namer: ApprovalNamer {
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
        let indexEnd = fromFile.range(of: ".swift")?.lowerBound
        let tempName = String(fromFile.prefix(upTo: indexEnd!))
        let baseName = tempName + "." + stack.testName
        return baseName
    }
}

private class StackDemangler {
    private(set) var className = ""
    private(set) var testName = ""

    func extractNames() -> Self {
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
            let classAndMethod = String(splitResult.last!)
            className = extractClassName(result: classAndMethod)
            testName = extractTestName(result: classAndMethod)
        } catch {
            print("Error in \(#function): \(error)")
        }
        return self
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

    private func extractTestName(result: String) -> String {
        let testNameWithParens = String(result.suffix(from: (result.range(of: ".")?.upperBound)!))
        let testName = String(testNameWithParens.prefix(upTo: (testNameWithParens.range(of: "(")?.lowerBound)!))
        return testName
    }

    private func extractClassName(result: String) -> String {
        let className = String(result.prefix(upTo: (result.range(of: ".")?.lowerBound)!))
        return className
    }
}
