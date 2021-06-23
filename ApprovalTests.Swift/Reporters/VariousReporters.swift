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
