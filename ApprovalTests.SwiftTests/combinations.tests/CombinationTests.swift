import XCTest
#if os(OSX)
@testable import ApprovalTests_Swift
#elseif os(iOS)
@testable import ApprovalTests_iOS
#endif

class CombinationTests: XCTestCase {

    func threeParams(_ in1: Int, _ in2: Int, _ in3: Int) -> Int {
        return in1 + in2 + in3
    }

    func twoIntParams(_ in1: Int, _ in2: Int) -> Int {
        return in1 * in2
    }

    func twoFloatParams(_ in1: Float, _ in2: Float) -> Float {
        return in1 * in2
    }

    func doubleInt(_ x: Int) -> Int {
        return 2 * x
    }

    func doubleFloat(_ x: Float) -> Float {
        return 2 * x
    }

    func threeMixedParams(_ anInt: Int, _ aFloat: Float, _ aString: String) -> String {
        return String("\(anInt) \(aFloat) \(aString)")
    }

    func testCombinationsSingleParameterInt() {
        try! CombinationApprovals.verifyAllCombinations(doubleInt, [1, 2, 3, 4, 5])
    }

    func testCombinationsSingleParameterFloat() {
        try! CombinationApprovals.verifyAllCombinations(doubleFloat, [1.1, 2.2, 3.3, 4.4, 5.5])
    }

    func testCombinationsTwoParametersInt() {
        try! CombinationApprovals.verifyAllCombinations(twoIntParams, [1, 2], [3, 4])
    }

    func testCombinationsMixedParameters() {
        try! CombinationApprovals.verifyAllCombinations(threeMixedParams, [1, 2, 3], [4.4, 5.5], ["String1", "String2", "String3", "String4"])
    }

    func testCombinationsFourParameters() {
        let inCall: (Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9])
    }

    func testCombinationsFiveParameters() {
        let inCall: (Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11])
    }

    func testCombinationsSixParameters() {
        let inCall: (Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13])
    }

    func testCombinationsSevenParameters() {
        let inCall: (Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15])
    }

    func testCombinationsEightParameters() {
        let inCall: (Int, Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15], [16, 17])
    }

    func testCombinationsNineParameters() {
        let inCall: (Int, Int, Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8
            return String(sum)
        }

        try! CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15], [16, 17], [18, 19])
    }

}
