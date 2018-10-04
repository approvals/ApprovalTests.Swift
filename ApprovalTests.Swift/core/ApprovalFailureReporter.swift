import Foundation

public protocol ApprovalFailureReporter {
    func report(received: String, approved: String)
}
