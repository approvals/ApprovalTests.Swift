#if os(OSX)
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
    
#elseif os(iOS)
    import Foundation

    /**
     A reporter that launches an external diff tool.

     For iOS, run iOSApprovalsWatcher.py to have your Mac watch for received files and launch the diff tool.
     */
    public class GenericDiffReporter: GenericDiffReporterBase {
        override public func runProcess(received: String, approved: String) throws {
            HelpMessages.displayIOSWatcherMessage()
            let process = Self.createCommandLine(received, approved, arguments, programPath)
            var fileURL = URL(fileURLWithPath: received)
            fileURL.deleteLastPathComponent()
            fileURL = fileURL.appendingPathComponent("command.sh")
            do {
                try process.write(toFile: fileURL.path, atomically: true, encoding: .utf8)
            } catch {
                print("An error occurred writing file:" + received)
                print("Error: \(error)")
            }
        }

        public static func createCommandLine(
            _ received: String,
            _ approved: String,
            _ arguments: (String, String) -> [String],
            _ programPath: String
        ) -> String {
            let arguments2 = arguments(formatForCommandLine(received), formatForCommandLine(approved))
            let process1 = "\(programPath) \(arguments2.joined(separator: " "))"
            let process = "#!/bin/bash\n\(process1)"
            return process
        }

        private class func formatForCommandLine(_ fileName: String) -> String {
            if fileName.contains(" ") {
                return "\"\(fileName)\""
            }
            return fileName
        }
    }

#endif
