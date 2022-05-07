#if os(macOS)

    import Foundation

    /**
     A reporter that launches an external diff tool.
     */
    public class GenericDiffReporter: GenericDiffReporterBase {
        override public func runProcess(received: String, approved: String) throws {
            let process = makeProcess(received: received, approved: approved)
            try process.run()
        }

        public func makeProcess(received: String, approved: String) -> Process {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: programPath)
            process.arguments = arguments(received, approved)
            process.terminationHandler = { process in
                print("\ndidFinish: \(!process.isRunning)")
            }
            return process
        }
    }

#endif
