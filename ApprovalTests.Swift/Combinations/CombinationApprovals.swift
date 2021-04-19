class INUNUSED {
    var description: String { "SKIP" }
}

public enum CombinationApprovals {

    public static func verifyAllCombinations<IN1, OUT>(
            _ call: @escaping (IN1) -> OUT,
            _ params1: [IN1],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
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

        let params2 = [INUNUSED()]
        let params3 = [INUNUSED()]
        let params4 = [INUNUSED()]
        let params5 = [INUNUSED()]
        let params6 = [INUNUSED()]
        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
    }

    public static func verifyAllCombinations<IN1, IN2, OUT>(
            _ call: @escaping (IN1, IN2) -> OUT,
            _ params1: [IN1],
            _ params2: [IN2],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
            var _ = $2
            var _ = $3
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0, $1)
        }

        let params3 = [INUNUSED()]
        let params4 = [INUNUSED()]
        let params5 = [INUNUSED()]
        let params6 = [INUNUSED()]
        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, OUT>(
            _ call: @escaping (IN1, IN2, IN3) -> OUT,
            _ params1: [IN1],
            _ params2: [IN2],
            _ params3: [IN3],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
            var _ = $3
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0, $1, $2)
        }

        let params4 = [INUNUSED()]
        let params5 = [INUNUSED()]
        let params6 = [INUNUSED()]
        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, OUT>(
            _ call: @escaping (IN1, IN2, IN3, IN4) -> OUT,
            _ params1: [IN1],
            _ params2: [IN2],
            _ params3: [IN3],
            _ params4: [IN4],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, IN4, INUNUSED, INUNUSED, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
            var _ = $4
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0, $1, $2, $3)
        }

        let params5 = [INUNUSED()]
        let params6 = [INUNUSED()]
        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, OUT>(
            _ call: @escaping (IN1, IN2, IN3, IN4, IN5) -> OUT,
            _ params1: [IN1],
            _ params2: [IN2],
            _ params3: [IN3],
            _ params4: [IN4],
            _ params5: [IN5],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, INUNUSED, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
            var _ = $5
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0, $1, $2, $3, $4)
        }

        let params6 = [INUNUSED()]
        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
    }

    public static func verifyAllCombinations<IN1, IN2, IN3, IN4, IN5, IN6, OUT>(
            _ call: @escaping (IN1, IN2, IN3, IN4, IN5, IN6) -> OUT,
            _ params1: [IN1],
            _ params2: [IN2],
            _ params3: [IN3],
            _ params4: [IN4],
            _ params5: [IN5],
            _ params6: [IN6],
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, INUNUSED, INUNUSED, INUNUSED) -> OUT = {
            var _ = $6
            var _ = $7
            var _ = $8
            return call($0, $1, $2, $3, $4, $5)
        }

        let params7 = [INUNUSED()]
        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
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
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, INUNUSED, INUNUSED) -> OUT = {
            var _ = $7
            var _ = $8
            return call($0, $1, $2, $3, $4, $5, $6)
        }

        let params8 = [INUNUSED()]
        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
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
            file: StaticString = #filePath,
            line: UInt = #line
    ) throws {
        let outcall: (IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, INUNUSED) -> OUT = {
            var _ = $8
            return call($0, $1, $2, $3, $4, $5, $6, $7)
        }

        let params9 = [INUNUSED()]
        try verifyAllCombinations(outcall, params1, params2, params3, params4, params5, params6, params7, params8, params9, file: file, line: line)
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
                                            let result = String("\(call(in1, in2, in3, in4, in5, in6, in7, in8, in9))")
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
        try Approvals.verify(output, file: file, line: line)
    }

    private static func extracted(_ array: [Any]) -> [Any] {
        var list = [Any]()

        for input in array {
            if String(describing: type(of: input)) == "INUNUSED" {
                continue
            }
            list.append(input)
        }
        return list
    }

}
