import Foundation

class KaleidoscopeReporter: ApprovalFailureReporter {

    func report(received: String, approved: String) -> Bool {
        var workingReceived = received
        var workingApproved = approved

        let newApproved = workingApproved.replacingOccurrences(of: ":::", with: "")
        workingApproved = newApproved

        let newReceived = workingReceived.replacingOccurrences(of: ":::", with: "")
        workingReceived = newReceived

        let newApproved2 = workingApproved.replacingOccurrences(of: " ", with: "\\ ")
        workingApproved = newApproved2

        let newReceived2 = workingReceived.replacingOccurrences(of: " ", with: "\\ ")
        workingReceived = newReceived2

        let process = Process()
//        process.executableURL = URL(fileURLWithPath:"/Applications/Kaleidoscope.app/Contents/MacOS/Kaleidoscope")
        process.executableURL = URL(fileURLWithPath:"/usr/local/bin/ksdiff")
        process.arguments = [workingReceived, workingApproved]
        print("-----> \(String(describing: process.executableURL!)) \(String(describing: process.arguments!))")
        process.terminationHandler = { (process) in
            print("\ndidFinish: \(!process.isRunning)")
        }
        do {
            try process.run()
            return true
        } catch {
            return false
        }
    }
}
