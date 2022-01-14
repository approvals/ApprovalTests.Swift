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
        var s: [String] = []
        s.append("Approval")
        s.append("Tests")
        try Approvals.verifyAll(s, label: "Text")
    }
}

private class MyClass: CustomStringConvertible {
    var value = "ApprovalTests"

    var description: String { "MyClass: \(value)" }
}
