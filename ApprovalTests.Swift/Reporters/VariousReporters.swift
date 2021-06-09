class ReportWithDiffMerge: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/DiffMerge.app/Contents/MacOS/DiffMerge", arguments: { received, approved in
            ["--nosplash", received, approved]
        })
    }
}

class ReportWithBeyondCompare: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/Beyond Compare.app/Contents/MacOS/bcomp")
    }
}

// Requires Tools->Create Command-line Launcher
class ReportWithAppCode: GenericDiffReporter {
    init() {
        super.init(programPath: "/usr/local/bin/appcode", arguments: { received, approved in
            ["diff", received, approved]
        })
    }
}

class ReportWithKdiff3: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/kdiff3.app/Contents/MacOS/kdiff3", arguments: { received, approved in
            [received, approved, "-m"]
        })
    }
}

class ReportWithP4Merge: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/p4merge.app/Contents/MacOS/p4merge")
    }
}

class ReportWithTKDiff: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/TkDiff.app/Contents/MacOS/tkdiff")
    }
}

class ReportWithVisualStudioCode: GenericDiffReporter {
    init() {
        super.init(programPath: "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code", arguments: { received, approved in
            ["-d", received, approved]
        })
    }
}
