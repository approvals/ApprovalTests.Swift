import Foundation

/**
 A reporter that creates a command line `mv` command for approving the last failed test, and places it on the clipboard.
 
 This will overwrite the previous clipboard contents.
 */
public class ReportMoveCommandToClipboard: EquatableFailureReporter {
    public override init() {}

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToClipboard
    }

    public override func report(received: String, approved: String) -> Bool {
        let command = ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved)
        SystemUtils.pasteToClipboard(command)
        return true
    }

    public static func makeCommandLineMove(received: String, approved: String) -> String {
        "mv \"\(received)\" \"\(approved)\""
    }
}

public class ReportMoveCommandToConsole: EquatableFailureReporter {
    public override init() {}

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToConsole
    }

    public override func report(received: String, approved: String) -> Bool {
        print(HelpMessages.lineSeparator)
        print("To approve:\n")
        let command = ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved)
        print(command)
        print(HelpMessages.lineSeparator)
        return true
    }
}

public class HelpMessages {
    static let lineSeparator = "*********************************************************"

    public static func displayIOSWatcherMessage() {
        print(HelpMessages.lineSeparator)
        print("You are running tests from iOS. You will need to turn on the watcher to launch reporters.")
        print("./iOSApprovalsWatcher.py [path_to_tests]")
        print(HelpMessages.lineSeparator)
    }
}
