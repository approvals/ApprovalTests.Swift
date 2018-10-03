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
class IN4 {
    var description: String {return "SKIP"}
}
class IN5 {
    var description: String {return "SKIP"}
}
class IN6 {
    var description: String {return "SKIP"}
}
class IN7 {
    var description: String {return "SKIP"}
}
class IN8 {
    var description: String {return "SKIP"}
}
class IN9 {
    var description: String {return "SKIP"}
}

class CombinationApprovals {

    public static func verifyAllCombinations<IN1, OUT>(_ call: @escaping (IN1) -> OUT, _ params1: Array<IN1>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $1
            var _ = $2
            var _ = $3
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0)
        }

        let params2: [IN2] = [IN2()]
        let params3: [IN3] = [IN3()]
        let params4: [IN4] = [IN4()]
        let params5: [IN5] = [IN5()]
        let params6: [IN6] = [IN6()]
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, OUT>(_ call: @escaping (IN1, IN2) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $2
            var _ = $3
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0,$1)
        }

        let params3: [IN3] = [IN3()]
        let params4: [IN4] = [IN4()]
        let params5: [IN5] = [IN5()]
        let params6: [IN6] = [IN6()]
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, OUT>(_ call: @escaping (IN1, IN2, IN3) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $3
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0,$1,$2)
        }
        
        let params4: [IN4] = [IN4()]
        let params5: [IN5] = [IN5()]
        let params6: [IN6] = [IN6()]
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, OUT>(_ call: @escaping (IN1, IN2, IN3, IN4) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>, _ params4: Array<IN4>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0,$1,$2,$3)
        }
        
        let params5: [IN5] = [IN5()]
        let params6: [IN6] = [IN6()]
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, OUT>(_ call: @escaping (IN1, IN2, IN3, IN4, IN5) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>, _ params4: Array<IN4>, _ params5: Array<IN5>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0,$1,$2,$3,$4)
        }
        
        let params6: [IN6] = [IN6()]
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, OUT>(_ call: @escaping (IN1, IN2, IN3, IN4, IN5, IN6) -> OUT, _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>, _ params4: Array<IN4>, _ params5: Array<IN5>, _ params6: Array<IN6>) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9 ) -> (OUT) = {
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0,$1,$2,$3,$4,$5)
        }
        
        let params7: [IN7] = [IN7()]
        let params8: [IN8] = [IN8()]
        let params9: [IN9] = [IN9()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, OUT>(_ call: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9) -> OUT,
         _ params1: Array<IN1>, _ params2: Array<IN2>, _ params3: Array<IN3>,
         _ params4: Array<IN4>, _ params5: Array<IN5>, _ params6: Array<IN6>,
         _ params7: Array<IN7>, _ params8: Array<IN8>, _ params9: Array<IN9> ) throws {
        var output = String()
        for in1 in params1 {
            for in2 in params2 {
                for in3 in params3 {
                    for in4 in params4 {
                        for in5 in params5 {
                            for in6 in params6 {
                                for in7 in params7 {
                                    for in8 in params8 {
                                        for in9 in params9 {
                                            let result = String( "\(call(in1,in2,in3,in4,in5,in6,in7,in8,in9))" )
                                            let someArray = [in1, in2, in3, in4, in5, in6, in7, in8, in9] as [Any]
                                            let foo = extracted(someArray)
                                            output.append(String("\(foo) -> \(result)\n"))
                                        }
                                    }
                                }
                            }
                        }
                    }
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
                String(describing: type(of: input)) == "IN3" ||
                String(describing: type(of: input)) == "IN4" ||
                String(describing: type(of: input)) == "IN5" ||
                String(describing: type(of: input)) == "IN6" ||
                String(describing: type(of: input)) == "IN7" ||
                String(describing: type(of: input)) == "IN8" ||
                String(describing: type(of: input)) == "IN9") {
                continue
            }
            list.append(input)
        }
        return list
    }

}
