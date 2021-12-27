#if os(iOS)

    import Foundation

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
