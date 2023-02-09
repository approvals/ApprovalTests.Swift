#if os(iOS)
import UIKit
#endif

public enum NamerFactory {
    public static func withParameters(options: Options = Options(), _ parameters: String ...) -> Options {
        return withParameters(options: options, parameters)
    }

    public static func withParameters(options: Options = Options(), _ parameters: [String]) -> Options {
        let namer = options.getNamer("", "")
        var parameters = parameters
        if namer is ParameterizedNamer {
            let preParameters = (namer as! ParameterizedNamer).getParameters()
            parameters = preParameters + parameters
        }
      return options.with { (filePath: String, functionName:String) -> ApprovalNamer in
            ParameterizedNamer(filePath, functionName, parameters)
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
    #if os(iOS)
        UIDevice.current.name
    #elseif canImport(Host)
        Host.current().localizedName ?? "unknown_host"
    #else
        "unknown_host"
    #endif
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
    #elseif arch(powerpc64le)
        return "powerpc64le"
    #elseif arch(s390x)
        return "s390x"
    #elseif arch(wasm32)
        return "wasm32"
    #elseif arch(x86_64)
        return "x86_64"
    #else
        return "unknown_machine_architecture"
    #endif
}
