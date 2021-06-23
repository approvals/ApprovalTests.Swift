#if os(macOS)

    import Foundation
    public class GenericDiffReporter: GenericDiffReporterBase {
        public override func runProcess(received: String, approved: String) throws {
            let process = makeProcess(received: received, approved: approved)
            try process.run()
        }

        public func makeProcess(received: String, approved: String) -> Process {
            let (workingReceived, workingApproved) = cleanUpFileNames(received: received, approved: approved)

            let process = Process()
            process.executableURL = URL(fileURLWithPath: programPath)
            process.arguments = arguments(workingReceived, workingApproved)
            process.terminationHandler = { (process) in
                print("\ndidFinish: \(!process.isRunning)")
            }
            return process
        }
    }

#endif
