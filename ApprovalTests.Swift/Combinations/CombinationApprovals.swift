public enum CombinationApprovals {
    private struct UNUSED {
        static let parameter = [UNUSED()]
    }

    private static var unused: [UNUSED] { [UNUSED()] }

    public static func verifyAllCombinations<IN1, OUT>(
        _ call: @escaping (IN1) -> OUT,
        _ params1: [IN1],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $1
            let _ = $2
            let _ = $3
            let _ = $4
            let _ = $5
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1,
            unused, unused, unused, unused, unused, unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, OUT>(
        _ call: @escaping (IN1, IN2) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $2
            let _ = $3
            let _ = $4
            let _ = $5
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0, $1)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2,
            unused, unused, unused, unused, unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, OUT>(
        _ call: @escaping (IN1, IN2, IN3) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $3
            let _ = $4
            let _ = $5
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0, $1, $2)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3,
            unused, unused, unused, unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, OUT>(
        _ call: @escaping (IN1, IN2, IN3, IN4) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, IN4, UNUSED, UNUSED, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $4
            let _ = $5
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0, $1, $2, $3)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3, params4,
            unused, unused, unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, OUT>(
        _ call: @escaping (IN1, IN2, IN3, IN4, IN5) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        _ params5: [IN5],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, IN4, IN5, UNUSED, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $5
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0, $1, $2, $3, $4)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3, params4, params5,
            unused, unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, OUT>(
        _ call: @escaping (IN1, IN2, IN3, IN4, IN5, IN6) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        _ params5: [IN5],
        _ params6: [IN6],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, IN4, IN5, IN6, UNUSED, UNUSED, UNUSED) -> OUT = {
            let _ = $6
            let _ = $7
            let _ = $8
            return call($0, $1, $2, $3, $4, $5)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3, params4, params5, params6,
            unused, unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, IN7, OUT>(
        _ call: @escaping (IN1, IN2, IN3, IN4, IN5, IN6, IN7) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        _ params5: [IN5],
        _ params6: [IN6],
        _ params7: [IN7],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, UNUSED, UNUSED) -> OUT = {
            let _ = $7
            let _ = $8
            return call($0, $1, $2, $3, $4, $5, $6)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3, params4, params5, params6, params7,
            unused, unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, OUT>(
        _ call: @escaping (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        _ params5: [IN5],
        _ params6: [IN6],
        _ params7: [IN7],
        _ params8: [IN8],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        let callWithAllParameters: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, UNUSED) -> OUT = {
            let _ = $8
            return call($0, $1, $2, $3, $4, $5, $6, $7)
        }
        try verifyAllCombinations(
            callWithAllParameters,
            params1, params2, params3, params4, params5, params6, params7, params8,
            unused,
            options: options, file: file, line: line
        )
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9, OUT>(
        _ call: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, IN9) -> OUT,
        _ params1: [IN1],
        _ params2: [IN2],
        _ params3: [IN3],
        _ params4: [IN4],
        _ params5: [IN5],
        _ params6: [IN6],
        _ params7: [IN7],
        _ params8: [IN8],
        _ params9: [IN9],
        options: Options = Options(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws {
        var output = ""
        for in1 in params1 {
            for in2 in params2 {
                for in3 in params3 {
                    for in4 in params4 {
                        for in5 in params5 {
                            for in6 in params6 {
                                for in7 in params7 {
                                    for in8 in params8 {
                                        for in9 in params9 {
                                            let result = "\(call(in1, in2, in3, in4, in5, in6, in7, in8, in9))"
                                            let someArray = [in1, in2, in3, in4, in5, in6, in7, in8, in9] as [Any]
                                            let extracted = someArray.filter { !($0 is UNUSED) }
                                            output += "\(extracted) -> \(result)\n"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        try Approvals.verify(output, options, file: file, line: line)
    }
}
