//
// Created by Industrial Logic on 9/30/18.
// Copyright (c) 2018 NA. All rights reserved.
//
import XCTest
@testable import ApprovalTests_Swift

class CombinationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func threeParams(_ in1: Int, _ in2: Int, _ in3: Int ) -> Int {
        return in1 + in2 + in3
    }

    func twoIntParams(_ in1: Int, _ in2: Int ) -> Int {
        return in1 * in2
    }

    func twoFloatParams( _ in1: Float, _ in2: Float ) -> Float {
        return in1 * in2
    }

    func doubleInt(_ x: Int) -> Int {
        return 2 * x
    }

    func doubleFloat(_ x: Float) -> Float {
        return 2 * x
    }

    func threeMixedParams( _ anInt: Int, _ aFloat: Float, _ aString: String ) -> String {
        return String("\(anInt) \(aFloat) \(aString)")
    }

    func testCombinationsSingleParameterInt() {
        try! CombinationApprovals.verifyAllCombinations(doubleInt, [1,2,3,4,5])
    }

    func testCombinationsSingleParameterFloat() {
        try! CombinationApprovals.verifyAllCombinations(doubleFloat, [1.1, 2.2, 3.3, 4.4, 5.5])
    }

    func testCombinationsTwoParametersInt() {
        try! CombinationApprovals.verifyAllCombinations(twoIntParams, [1, 2], [3, 4])
    }

    func testCombinationsMixedParameters() {
        try! CombinationApprovals.verifyAllCombinations(threeMixedParams, [1,2,3], [4.4, 5.5], ["String1", "String2", "String3", "String4"])
    }
}