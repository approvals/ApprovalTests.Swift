#if os(iOS)

    import Foundation

    /**
     A reporter that launches an external diff tool.
     
     For iOS, run ApprovalTests_SwiftTests/iOSApprovalsWatcher.py to have your Mac watch for
     received files and launch the diff tool.
     */
    public class GenericDiffReporter: GenericDiffReporterBase {
        public override func runProcess(received: String, approved: String) throws {
            let arguments2 = arguments(received, approved)
            let process1 = "\(programPath) \(arguments2.joined(separator: " "))"

            let process = "#!/bin/bash\n\(process1)"
            var fileUrl = URL(fileURLWithPath: received)
            fileUrl.deleteLastPathComponent()
            fileUrl = fileUrl.appendingPathComponent("command.sh")
            do {
                try process.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
            } catch {
                print("An error occurred writing file:" + received)
                print("Error: \(error)")
            }
        }
    }

#endif
