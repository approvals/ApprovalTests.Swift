class ParameterizedNamer: Namer {
    private let parameters: [String]

  public init(_ filePath: String, _ function:String, _ parameters: [String]) {
        self.parameters = parameters
        super.init(filePath, function)
    }
    
    override func sourceFilePath() -> String {
        super.sourceFilePath() + "." + parameters.joined(separator: ".")
    }

    func getParameters() -> [String] {
        return parameters
    }
}
