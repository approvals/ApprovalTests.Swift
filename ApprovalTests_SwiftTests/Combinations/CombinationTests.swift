#if os(macOS)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

// swiftlint:disable anonymous_argument_in_multiline_closure multiline_arguments

final class CombinationTests: XCTestCase {
    private func threeParams(_ in1: Int, _ in2: Int, _ in3: Int) -> Int {
        in1 + in2 + in3
    }

    private func twoIntParams(_ in1: Int, _ in2: Int) -> Int {
        in1 * in2
    }

    private func twoFloatParams(_ in1: Float, _ in2: Float) -> Float {
        in1 * in2
    }

    private func doubleInt(_ x: Int) -> Int {
        2 * x
    }

    private func doubleFloat(_ x: Float) -> Float {
        2 * x
    }

    private func threeMixedParams(_ anInt: Int, _ aFloat: Float, _ aString: String) -> String {
        "\(anInt) \(aFloat) \(aString)"
    }

    func testCombinationsSingleParameterInt() throws {
        try CombinationApprovals.verifyAllCombinations(
            doubleInt,
            [1, 2, 3, 4, 5]
        )
    }

    func testCombinationsSingleParameterFloat() throws {
        try CombinationApprovals.verifyAllCombinations(
            doubleFloat,
            [1.1, 2.2, 3.3, 4.4, 5.5]
        )
    }

    func testCombinationsTwoParametersInt() throws {
        try CombinationApprovals.verifyAllCombinations(
            twoIntParams,
            [1, 2], [3, 4]
        )
    }

    func testCombinationsMixedParameters() throws {
        try CombinationApprovals.verifyAllCombinations(
            threeMixedParams,
            [1, 2, 3], [4.4, 5.5], ["String1", "String2", "String3", "String4"]
        )
    }

    func testCombinationsFourParameters() throws {
        let inCall: (Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(inCall, [1, 2, 3], [4, 5], [6, 7], [8, 9])
    }

    func testCombinationsFiveParameters() throws {
        let inCall: (Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(
            inCall,
            [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11]
        )
    }

    func testCombinationsSixParameters() throws {
        let inCall: (Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(
            inCall,
            [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13]
        )
    }

    func testCombinationsSevenParameters() throws {
        let inCall: (Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(
            inCall,
            [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15]
        )
    }

    func testCombinationsEightParameters() throws {
        let inCall: (Int, Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(
            inCall,
            [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15], [16, 17]
        )
    }

    func testCombinationsNineParameters() throws {
        let inCall: (Int, Int, Int, Int, Int, Int, Int, Int, Int) -> String = {
            let sum = $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8
            return String(sum)
        }

        try CombinationApprovals.verifyAllCombinations(
            inCall,
            [1, 2, 3], [4, 5], [6, 7], [8, 9], [10, 11], [12, 13], [14, 15], [16, 17], [18, 19]
        )
    }
}
