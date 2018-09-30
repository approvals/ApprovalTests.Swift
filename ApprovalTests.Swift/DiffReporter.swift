//
// Created by Industrial Logic on 9/29/18.
// Copyright (c) 2018 NA. All rights reserved.
//

import Foundation

class DiffReporter: ApprovalFailureReporter {

    func report(received: String, approved: String) {
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
        process.executableURL = URL(fileURLWithPath:"/usr/local/bin/diffmerge")
        process.arguments = [workingReceived, workingApproved]
        process.terminationHandler = { (process) in
            print("\ndidFinish: \(!process.isRunning)")
        }
        do {
            try process.run()
        } catch {}
    }
}
