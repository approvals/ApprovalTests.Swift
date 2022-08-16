public enum NamerFactory {
    public static func withParameters(options: Options = Options(), _ parameters: String ...) -> Options {
        return withParameters(options: options, parameters)
    }

    public static func withParameters(options: Options = Options(), _ parameters: [String]) -> Options {
        let namer = options.getNamer("")
        var parameters = parameters
        if namer is ParameterizedNamer {
            let preParameters = (namer as! ParameterizedNamer).getParameters()
            parameters = preParameters + parameters
        }
        return options.with { (filePath: String) -> ApprovalNamer in
            ParameterizedNamer(filePath, parameters)
        }
    }

    public static func asChipArchitectureSpecificTest(options: Options = Options()) -> Options {
        withParameters(options: options, getMachineArchitecture())
    }

    public static func asMachineNameSpecificTest(options: Options = Options()) -> Options {
        withParameters(options: options, getMachineName())
    }

    public static func withAdditionalParameters(_ parameters: String ...) -> (Options) -> Options {
        return { (options: Options) -> Options in
            withParameters(options: options, parameters)
        }
    }
}

public func getMachineName() -> String {
    Host.current().localizedName ?? "unknown_host"
}

public func getMachineArchitecture() -> String {
    #if arch(arm)
        return "arm"
    #elseif arch(arm64)
        return "arm64"
    #elseif arch(i386)
        return "i386"
    #elseif arch(powerpc64)
        return "powerpc64"
    #elseif arch(x86_64)
        return "x86_64"
    #elseif arch(s390x)
        return "s390x"
    #elseif arch(wasm32)
        return "wasm32"
    #else
        return "unknown_machine_architecture"
    #endif
}
