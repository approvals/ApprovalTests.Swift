
/**
 A reporter that creates a command line `mv` command for approving the last failed test, and prints it on the console.
 */
public class ReportMoveCommandToConsole: EquatableFailureReporter {
    override public init() {}

    override public func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToConsole
    }

    override public func report(received: String,
                                approved: String,
                                file _: StaticString,
                                
                                line _: UInt) -> Bool
    {
        print(HelpMessages.lineSeparator)
        print("To approve:\n")
        print(ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved))
        print(HelpMessages.lineSeparator)
        return true
    }
}
