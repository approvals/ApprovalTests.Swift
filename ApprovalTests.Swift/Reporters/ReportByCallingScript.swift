import Foundation

public class ReportByCallingScript: GenericDiffReporter {
    private let createIfNeeded: Bool

    public init(createIfNeeded: Bool = false, _ file: String = #filePath) {
        self.createIfNeeded = createIfNeeded
        let parentDirectory = URL(fileURLWithPath: file).deletingLastPathComponent().path
        super.init(
            programPath: "\(parentDirectory)/approvals_reporter.sh"
        )
    }

    override public func doesProgramExist(_ programPath: String) -> Bool {
        if super.doesProgramExist(programPath) {
            return true
        }
        if createIfNeeded {
            let text = """
            #!/bin/bash

            echo Reporting from script
            echo "received: $1"
            echo "approved: $2"
            """
            do {
                try text.write(to: URL(fileURLWithPath: programPath), atomically: true, encoding: String.Encoding.utf8)
                try FileManager.default.setAttributes([.posixPermissions: 0o777], ofItemAtPath: programPath)
            } catch {
                print("Unable to write file at \(programPath)")
            }
            return true
        }
        print("""
        ReportByCallingScript script not found
        Expected location: \(programPath)
        Note: You can create a starting script by calling ReportByCallingScript(createIfNeeded: true)
        """)
        return false
    }
}
