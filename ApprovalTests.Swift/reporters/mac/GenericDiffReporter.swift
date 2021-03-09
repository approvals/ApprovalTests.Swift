import Foundation

class GenericDiffReporter: ApprovalFailureReporter {
    private let programPath: String
    private let arguments: (String, String) -> [String]

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

    func report(received: String, approved: String) -> Bool {
        if !FileManager.default.fileExists(atPath: programPath) {
            return false
        }

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

        let process = Process()
        process.executableURL = URL(fileURLWithPath: programPath)
        process.arguments = arguments(workingReceived, workingApproved)
        process.terminationHandler = { (process) in
            print("\ndidFinish: \(!process.isRunning)")
        }
        do {
            try process.run()
            return true
        } catch {
            return false
        }
    }
}
