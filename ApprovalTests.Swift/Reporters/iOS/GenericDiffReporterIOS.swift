#if os(iOS)

    import Foundation

    class GenericDiffReporter: GenericDiffReporterBase {
        override func runProcess(received: String, approved: String) throws {
            let (workingReceived, workingApproved) = cleanUpFileNames(received: received, approved: approved)

            let arguments2 = arguments(workingReceived, workingApproved)
            let process1 = "\(programPath) \(arguments2.joined(separator: " "))"

            let process = "#!/bin/bash\n\(process1)"
            var fileUrl = URL(fileURLWithPath: workingReceived)
            fileUrl.deleteLastPathComponent()
            fileUrl = fileUrl.appendingPathComponent("command.sh")
            do {
                try process.write(toFile: fileUrl.path, atomically: true, encoding: .utf8)
            } catch {
                print("An error occurred writing file:" + workingReceived)
                print("Error: \(error)")
            }
        }
    }

#endif
