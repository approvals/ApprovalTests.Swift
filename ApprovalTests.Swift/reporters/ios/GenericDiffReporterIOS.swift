import Foundation

#if os(iOS)

class GenericDiffReporter: GenericDiffReporterBase {
    override func runProcess(received: String, approved: String) throws {
        var (workingReceived, workingApproved) = cleanUpFileNames(received: received, approved: approved)

        let arguments2 = arguments(workingReceived, workingApproved)
        var process1 = "\(programPath) \(arguments2.joined(separator: " "))"

        var process = "#!/bin/bash\n\(process1)"
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
