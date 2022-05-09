import Foundation

public let TEXT = [".txt", ".csv", ".htm", ".html", ".xml", ".eml", ".java", ".css", ".js", ".json", ".md"]
public let IMAGES = [".png", ".gif", ".jpg", ".jpeg", ".bmp", ".tif", ".tiff"]
public let TEXT_AND_IMAGES = TEXT + IMAGES

public class GenericDiffReporterBase: EquatableFailureReporter {
    let programPath: String
    let fileTypes: [String]
    let arguments: (String, String) -> [String]

    public init(
        programPath: String,
        _ fileTypes: [String] = TEXT,
        arguments: @escaping (String, String) -> [String] = { received, approved in
            [received, approved]
        }
    ) {
        self.programPath = programPath
        self.fileTypes = fileTypes
        self.arguments = arguments
    }

    override public func report(received: String, approved: String) -> Bool {
        if !doesProgramExist(programPath) {
            return false
        }
        if !isFileExtensionHandled(received) {
            return false
        }
        do {
            try runProcess(received: received, approved: approved)
            return true
        } catch {
            print("Error in \(#function) for received \"\(received)\", approved \"\(approved)\": \(error)")
            return false
        }
    }

    private func isFileExtensionHandled(_ filePath: String) -> Bool {
        let fileExtensionWithDot = "." + (filePath as NSString).pathExtension
        return fileTypes.contains(fileExtensionWithDot)
    }

    public func doesProgramExist(_ programPath: String) -> Bool {
        FileManager.default.fileExists(atPath: programPath)
    }

    override public func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? GenericDiffReporterBase else { return false }
        return programPath == other.programPath
    }

    public func runProcess(received _: String, approved _: String) throws {}
}
