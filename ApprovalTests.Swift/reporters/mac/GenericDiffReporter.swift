import Foundation

class GenericDiffReporter: GenericDiffReporterBase {
    override func runProcess(received: String, approved: String) throws {
        var (workingReceived, workingApproved) = cleanUpFileNames(received: received, approved: approved)

        let process = Process()
        process.executableURL = URL(fileURLWithPath: programPath)
        process.arguments = arguments(workingReceived, workingApproved)
        process.terminationHandler = { (process) in
            print("\ndidFinish: \(!process.isRunning)")
        }
        try process.run()
    }
}
