import XCTest

/**
 A reporter that outputs straight to XCTest.

 In addition to reporting the change using a standard XCTest assertion, this reporter also creates a command line `mv` command for approving the last failed test. It writes this command to the console and also places it on the clipboard.
 */
public class ReportContentsWithXCTest: EquatableFailureReporter {
    override public init() {}

    override public func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportContentsWithXCTest
    }

    override public func report(received: String,
                                approved: String,
                                file: StaticString,
                                line: UInt) -> Bool
    {
        // read the files into strings
        let approvedURL = URL(fileURLWithPath: approved)
        let receivedURL = URL(fileURLWithPath: received)

        var aText = ""
        var rText = ""
        do {
            aText = try String(contentsOf: approvedURL)
            rText = try String(contentsOf: receivedURL)
        } catch {
            SimpleLogger.printLineNumber()
            print("Error in \(#function) for received \"\(received)\", approved \"\(approved)\": \(error)")
            return false
        }
        let command = ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved)

        // copy to pasteboard
        SystemUtils.pasteToClipboard(command)

        // send command to system out
        let approveCommand = "To approve run : " + command
        print(approveCommand)
        XCTAssertEqual(aText, rText, file: file, line: line)

        return true
    }
}
