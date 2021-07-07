#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

private class Samples: XCTestCase {
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
        var s: [String] = []
        s.append("Approval")
        s.append("Tests")
        try Approvals.verifyAll("Text", s)
    }
}

class MyClass: CustomStringConvertible {
    var val = "ApprovalTests"

    var description: String { "MyClass: \(val)" }
}
