import Foundation

class ParameterizedNamer: Namer {
    private let parameters: [String]

    public init(_ filePath: String, _ parameters: [String]) {
        self.parameters = parameters
        super.init(filePath)
    }
    
    override func sourceFilePath() -> String {
        super.sourceFilePath() + "." + parameters.joined(separator: ".")
    }
}
