//
// Created by Industrial Logic on 9/30/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

class IN2 {
    var description: String {return "SKIP"}
}

class IN3 {
    var description: String {return "SKIP"}
}

class CombinationApprovals {

    public static func verifyAllCombinations<IN1, OUT>(_ call: @escaping (IN1) -> OUT, _ params1: Array<IN1>) throws {
        let outcall: (IN1, IN2, IN3 ) -> (OUT) = {
            var _ = $1
            var _ = $2
            return call($0)
        }

        let params2: [IN2] = [IN2()]
        let params3: [IN3] = [IN3()]
        try verifyAllCombinations(outcall, params1, params2, params3)
    }

    public static func verifyAllCombinations<IN1, IN2, OUT>(_ call: @escaping (IN1, IN2) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>) throws {
        let outcall: (IN1, IN2, IN3 ) -> (OUT) = {
            var _ = $2
            return call($0,$1)
        }

        let params3: [IN3] = [IN3()]
        try verifyAllCombinations(outcall, params1, params2, params3)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, OUT>(_ call: (IN1, IN2, IN3) -> OUT,
                                                 _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>) throws {
        var output = String()
        for in1 in params1 {
            for in2 in params2 {
                for in3 in params3 {
                    let result = String( "\(call(in1,in2,in3))" )
                    let someArray = [in1, in2, in3] as [Any]
                    let foo = extracted(someArray)
                    output.append(String("\(foo) -> \(result)\n"))
                }
            }
        }
        try Approvals.verify(output)
    }

    private static func extracted(_ array: [Any]) -> Array<Any> {
        var list = Array<Any>()

        for input in array {
            if (String(describing: type(of: input)) == "IN1" ||
                    String(describing: type(of: input)) == "IN2" ||
                    String(describing: type(of: input)) == "IN3") {
                continue
            }
            list.append(input)
        }

        return list
    }

}
