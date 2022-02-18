#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

// begin-snippet: sample_test
class SampleArrayTests: XCTestCase {

    func testList() throws {
        var names = ["Llewellyn", "James", "Dan", "Jason", "Katrina"]
        names.sort()
        try Approvals.verifyAll(names, label: "")
    }
// end-snippet

    func testEmptyList() throws {
        let names: [String] = []
        try Approvals.verifyAll(names, label: "Names")
    }

    func testListOf10() throws {
        let names = [
            "alpha",
            "beta",
            "gamma",
            "delta",
            "epsilon",
            "zeta ",
            "eta",
            "theta",
            "iota",
            "kappa",
        ]
        try Approvals.verifyAll(names, label: "Greek")
    }

    func testListOf11() throws {
        let names = [
            "alpha",
            "beta",
            "gamma",
            "delta",
            "epsilon",
            "zeta ",
            "eta",
            "theta",
            "iota",
            "kappa",
            "lambda"
        ]
        try Approvals.verifyAll(names, label: "Greek")
    }

    func testDictionary() throws {
        let dict: [Int: String] = [
            3: "Three",
            2: "Two",
            1: "One",
        ]
        try Approvals.verify(dict)
    }

}
