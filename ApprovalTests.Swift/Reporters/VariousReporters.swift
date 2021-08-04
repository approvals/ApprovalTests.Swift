import System

public class ReportWithDiffMerge: GenericDiffReporter {
    public init() {
        super.init(
                programPath: "/Applications/DiffMerge.app/Contents/MacOS/DiffMerge",
                arguments: { received, approved in
                    ["--nosplash", received, approved]
                }
        )
    }
}

public class ReportByCallingScript: GenericDiffReporter {
    private let createIfNeeded: Bool

    public init(createIfNeeded: Bool = false, _ file: String = #filePath) {
        self.createIfNeeded = createIfNeeded
        let parentDirectory = URL(fileURLWithPath: file).deletingLastPathComponent().path
        super.init(
                programPath: "\(parentDirectory)/approvals_reporter.sh"
        )
    }

    public override func doesProgramExist(_ programPath: String) -> Bool {
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

public class ReportWithBeyondCompare: GenericDiffReporter {
    public init() {
        super.init(programPath: "/Applications/Beyond Compare.app/Contents/MacOS/bcomp")
    }
}

// Requires Tools->Create Command-line Launcher
public class ReportWithAppCode: GenericDiffReporter {
    public init() {
        super.init(
                programPath: "/usr/local/bin/appcode",
                arguments: { received, approved in
                    ["diff", received, approved]
                }
        )
    }
}

public class ReportWithKdiff3: GenericDiffReporter {
    public init() {
        super.init(
                programPath: "/Applications/kdiff3.app/Contents/MacOS/kdiff3",
                arguments: { received, approved in
                    [received, approved, "-m"]
                }
        )
    }
}

public class ReportWithKaleidoscope: GenericDiffReporter {
    public init() {
        super.init(programPath: "/usr/local/bin/ksdiff")
    }
}

public class ReportWithP4Merge: GenericDiffReporter {
    public init() {
        super.init(programPath: "/Applications/p4merge.app/Contents/MacOS/p4merge")
    }
}

public class ReportWithTKDiff: GenericDiffReporter {
    public init() {
        super.init(programPath: "/Applications/TkDiff.app/Contents/MacOS/tkdiff")
    }
}

public class ReportWithVisualStudioCode: GenericDiffReporter {
    public init() {
        super.init(
                programPath: "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code",
                arguments: { received, approved in
                    ["-d", received, approved]
                }
        )
    }
}

