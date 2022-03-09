#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class SampleTests: XCTestCase {

    func testString() throws {
        var s = "Approval"
        s += "Tests"
        try Approvals.verify(s)
    }

    func testObject() throws {
        let myObject = MyClass()
        try Approvals.verify(String(describing: myObject))
    }

    func testArray() throws {
        try Approvals.verifyAll(getWords(), label: "Text")
    }

    func testArray2() throws {
        try Approvals.verifyAll("words", getWords())
    }

    func testArrayWithLabeler() throws {
        try Approvals.verifyAll("uppercased", getWords()) { w in
            "\(w) -> \(w.uppercased())"
        }
    }

    func testArrayWithLabeler2() throws {
        try Approvals.verifyAll("", getWords(), label: "text")
    }

    private func getWords() -> [String] {
        var s: [String] = []
        s.append("Approval")
        s.append("Tests")
        return s
    }
}

private class MyClass: CustomStringConvertible {
    var value = "ApprovalTests"

    var description: String { "MyClass: \(value)" }
}
