#if os(macOS)

    import Foundation

    class GenericDiffReporter: GenericDiffReporterBase {
        override func runProcess(received: String, approved: String) throws {
            let process = getProcess(received: received, approved: approved)
            try process.run()
        }

        func getProcess(received: String, approved: String) -> Process {
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
