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
}
