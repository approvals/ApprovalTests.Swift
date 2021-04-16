import Foundation

class GenericDiffReporterBase: EquatableFailureReporter {
    let programPath: String
    let arguments: (String, String) -> [String]
    
    init(programPath: String) {
        self.programPath = programPath
        arguments = { received, approved in
            [received, approved]
        }
    }

    init(programPath: String, arguments: @escaping (String, String) -> [String]) {
        self.programPath = programPath
        self.arguments = arguments
    }

    override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let otherReporter = other as? GenericDiffReporterBase else { return false }
        return self.programPath == otherReporter.programPath
    }

    override func report(received: String, approved: String) -> Bool {
        if !FileManager.default.fileExists(atPath: programPath) {
            return false
        }
        do {
            try runProcess(received: received, approved: approved)
            return true
        } catch {
            return false
        }
    }

    func runProcess(received: String, approved: String) throws {
    }

    func cleanUpFileNames(received: String, approved: String) -> (String, String) {
        var workingReceived = received
        var workingApproved = approved

        let newApproved = workingApproved.replacingOccurrences(of: ":::", with: "")
        workingApproved = newApproved

        let newReceived = workingReceived.replacingOccurrences(of: ":::", with: "")
        workingReceived = newReceived

        let newApproved2 = workingApproved.replacingOccurrences(of: " ", with: "\\ ")
        workingApproved = newApproved2

        let newReceived2 = workingReceived.replacingOccurrences(of: " ", with: "\\ ")
        workingReceived = newReceived2
        return (workingReceived, workingApproved)
    }
}
