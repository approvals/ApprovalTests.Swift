import Foundation

class Namer: ApprovalNamer {
    var className = ""
    var testName = ""
    var fromFile = ""

    init(_ file: String) {
        fromFile = file
    }

    func getApprovalName() -> String {
        demangleStack()
        return className + "." + testName
    }

    func getSourceFilePath() -> String {
        demangleStack()

        let indexEnd = fromFile.range(of: ".swift")?.lowerBound
        let tempName = String(fromFile.prefix(upTo: indexEnd!))
        let baseName = String(format: "%@.%@", tempName, testName)
        return baseName;
    }

    private func demangleStack() {
        do {
            var result = ""

            let symbols = Thread.callStackSymbols


            let testDepth = selectElement(symbols: symbols)

            let index = symbols[testDepth].range(of: "$")?.lowerBound
            let tempName = String(symbols[testDepth].suffix(from: index!))

            let indexEnd = tempName.range(of: " ")?.lowerBound
            let mangledName = String(tempName.prefix(upTo: indexEnd!))

            let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
            result = swiftSymbol.print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))

            let splitResult = result.split(separator: " ")
            let classAndMethod = splitResult.last!

            className = extractClassName(result: String(classAndMethod))
            testName = extractTestName(result: String(classAndMethod))

        } catch {
            print("Got an error")
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
        return (depth - 3)
    }

    private func isTestCase(_ element: String) -> Bool {
        (element.range(of: "XCTest", options: .caseInsensitive) != nil)
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
