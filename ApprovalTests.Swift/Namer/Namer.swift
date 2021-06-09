import Foundation

class Namer: ApprovalNamer {
    private let fromFile: String

    init(_ file: String) {
        fromFile = file
    }

    func approvalName() -> String {
        do {
            let stack = try StackDemangler()
            return stack.className + "." + stack.testName
        } catch {
            print("Error in \(#function): \(error)")
            return "ERROR"
        }
    }

    func sourceFilePath() -> String {
        do {
            let stack = try StackDemangler()
            let indexEnd = fromFile.range(of: ".swift")?.lowerBound
            let tempName = String(fromFile.prefix(upTo: indexEnd!))
            let baseName = tempName + "." + stack.testName
            return baseName
        } catch {
            print("Error in \(#function): \(error)")
            return "ERROR"
        }
    }
}

private class StackDemangler {
    let className: String
    let testName: String

    init() throws {
        let symbols = Thread.callStackSymbols
        let testDepth = StackDemangler.selectElement(symbols: symbols)
        let index = symbols[testDepth].range(of: "$")?.lowerBound
        let tempName = String(symbols[testDepth].suffix(from: index!))
        let indexEnd = tempName.range(of: " ")?.lowerBound
        let mangledName = String(tempName.prefix(upTo: indexEnd!))
        let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
        let result = swiftSymbol.print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))
        let splitResult = result.split(separator: " ")
        let classAndMethod = splitResult.last!
        className = StackDemangler.extractClassName(result: String(classAndMethod))
        testName = StackDemangler.extractTestName(result: String(classAndMethod))
    }
    
    private static func selectElement(symbols trace: [String]) -> Int {
        var depth = 0
        for element in trace {
            if StackDemangler.isTestCase(element) {
                break
            }
            depth += 1
        }
        return depth - 3
    }

    private static func isTestCase(_ element: String) -> Bool {
        element.range(of: "XCTest", options: .caseInsensitive) != nil
    }

    private static func extractTestName(result: String) -> String {
        let testNameWithParens = String(result.suffix(from: (result.range(of: ".")?.upperBound)!))
        let testName = String(testNameWithParens.prefix(upTo: (testNameWithParens.range(of: "(")?.lowerBound)!))
        return testName
    }

    private static func extractClassName(result: String) -> String {
        let className = String(result.prefix(upTo: (result.range(of: ".")?.lowerBound)!))
        return className
    }
}
