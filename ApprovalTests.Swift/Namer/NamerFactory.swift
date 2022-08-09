public enum NamerFactory {
    public static func withParameters(options: Options = Options(), _ parameters: String ...) -> Options {
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
        let architecture = getMachineHardwareName()
        return withParameters(options: options, architecture)
    }
}

public func getMachineHardwareName() -> String {
    var sysInfo = utsname()
    let retVal = uname(&sysInfo)
    guard retVal == EXIT_SUCCESS else { return "uname_failure" }

    return String(cString: &sysInfo.machine.0, encoding: .utf8) ?? "uh oh"
}
