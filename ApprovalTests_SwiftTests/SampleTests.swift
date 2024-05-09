#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

final class SampleTests: XCTestCase {
    private var getWords = ["Approval", "Tests"]

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
        try Approvals.verifyAll(getWords, label: "Text")
    }

    func testArray2() throws {
        try Approvals.verifyAll(header: "words", getWords)
    }

    func testArrayWithLabeler() throws {
        try Approvals.verifyAll(header: "uppercased", getWords) { w in
            "\(w) -> \(w.uppercased())"
        }
    }

    func testArrayWithLabeler2() throws {
        try Approvals.verifyAll(header: "", getWords, label: "text")
    }
}

private class MyClass: CustomStringConvertible {
    var value = "ApprovalTests"

    var description: String { "MyClass: \(value)" }
}
