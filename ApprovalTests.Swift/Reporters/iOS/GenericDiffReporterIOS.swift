#if os(iOS)
    import Foundation

    /**
     A reporter that launches an external diff tool.

     For iOS, run iOSApprovalsWatcher.py to have your Mac watch for received files and launch the diff tool.
     */
    public class GenericDiffReporter: GenericDiffReporterBase {
        override public func runProcess(received: String, approved: String) throws {
            HelpMessages.displayIOSWatcherMessage()
            let arguments2 = arguments(received, approved)
            let process1 = "\(programPath) \(arguments2.joined(separator: " "))"

            let process = "#!/bin/bash\n\(process1)"
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
    }
#endif
