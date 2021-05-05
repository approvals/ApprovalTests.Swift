import Foundation

class ClipboardReporter: EquatableFailureReporter {

    override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard other is ClipboardReporter else { return false }
        return true
    }

    override func report(received: String, approved: String) -> Bool {
        let command = ClipboardReporter.getCommandLineMove(received: received, approved: approved)

        SystemUtils.pasteToClipboard(command)

        return true
    }

    static func getCommandLineMove(received: String, approved: String) -> String {
        let workingReceived = ClipboardReporter.cleanPathString(received)
        let workingApproved = ClipboardReporter.cleanPathString(approved)
        return "mv \(workingReceived) \(workingApproved)"
    }

    static private func cleanPathString(_ pathString: String) -> String {
        var workingPathString = pathString

        let removedColons = workingPathString.replacingOccurrences(of: ":::", with: "")
        workingPathString = removedColons

        let escapedSpaces = workingPathString.replacingOccurrences(of: " ", with: "\\ ")
        workingPathString = escapedSpaces

        return workingPathString
    }
}
