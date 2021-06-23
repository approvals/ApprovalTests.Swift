import Foundation

public class ReportMoveCommandToClipboard: EquatableFailureReporter {
    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToClipboard
    }

    public override func report(received: String, approved: String) -> Bool {
        let command = ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved)
        SystemUtils.pasteToClipboard(command)
        return true
    }

    static func makeCommandLineMove(received: String, approved: String) -> String {
        let workingReceived = ReportMoveCommandToClipboard.cleanPathString(received)
        let workingApproved = ReportMoveCommandToClipboard.cleanPathString(approved)
        return "mv \(workingReceived) \(workingApproved)"
    }

    private static func cleanPathString(_ pathString: String) -> String {
        var workingPathString = pathString

        let removedColons = workingPathString.replacingOccurrences(of: ":::", with: "")
        workingPathString = removedColons

        let escapedSpaces = workingPathString.replacingOccurrences(of: " ", with: "\\ ")
        workingPathString = escapedSpaces

        return workingPathString
    }
}
