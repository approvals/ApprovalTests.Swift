import Foundation

public class Namer: ApprovalNamer {
  private let file: String
  private let fileName: String
  private let functionName: String

  public init(_ file: String,_ function: String) {
    self.file = file
    self.fileName = URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent
    print("#@#", file, fileName, function)
    functionName = function.dropLast(2).description
  }

  public func approvalName() -> String {
    let names = StackDemangler().extractNames()
    return names.className + "." + functionName
  }

  public func sourceFilePath() -> String {
    let baseName = (file as NSString).deletingPathExtension
    return baseName + "." + functionName
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

private class StackDemangler {
  private let callStack = Thread.callStackSymbols

  func extractNames() -> ClassAndMethod {
    do {
      let mangledName = try mangledName(depth: findTestMethod())
      let swiftSymbol = try parseMangledSwiftSymbol(mangledName)
      let readableDescription = swiftSymbol
        .print(using: SymbolPrintOptions.simplified.union(.synthesizeSugarOnTypes))
      let classAndMethod = String(readableDescription.split(separator: " ").last!)
      return ClassAndMethod(classAndMethod: classAndMethod)
    } catch {
      print("Error in \(#function): \(error)")
      return ClassAndMethod(className: "ERROR", testName: "ERROR")
    }
  }

  private func mangledName(depth: Int) throws -> String {
    guard let dollarSignIndex = callStack[depth].firstIndex(of: "$") else {
      throw OptionalError()
    }
    let mangledNameAndOffset = callStack[depth].suffix(from: dollarSignIndex)
    guard
      let firstSpaceIndex = mangledNameAndOffset.firstIndex(of: " ") else {
      throw OptionalError()
    }
    return String(mangledNameAndOffset.prefix(upTo: firstSpaceIndex))
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

struct OptionalError: Error {}
