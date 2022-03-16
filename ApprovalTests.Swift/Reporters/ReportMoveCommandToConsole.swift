import Foundation

/**
 A reporter that creates a command line `mv` command for approving the last failed test, and prints it on the console.
 */
public class ReportMoveCommandToConsole: EquatableFailureReporter {
    public override init() {}

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToConsole
    }

    public override func report(received: String, approved: String) -> Bool {
        print(HelpMessages.lineSeparator)
        print("To approve:\n")
        print(ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved))
        print(HelpMessages.lineSeparator)
        return true
    }
}
