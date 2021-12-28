import Foundation

public class ExecutableReporter: ApprovalFailureReporter {
    private var reporter: ApprovalFailureReporter
    private var query: ExecutableQuery

    private init(_ reporter: ApprovalFailureReporter, _ query: ExecutableQuery) {
        self.reporter = reporter
        self.query = query
    }

    public func report(received: String, approved: String) -> Bool {
        if !reporter.report(received: received, approved: approved) {
            return false
        }
        let receivedExpanded = expand(received)
        let approvedExpanded = expand(approved)
        return reporter.report(received: receivedExpanded, approved: approvedExpanded)
    }

    private func expand(_ queryFile: String) -> String {
        let fileName = queryFile + ".query_results.txt"
        if FileManager.default.fileExists(atPath: queryFile) {
            let queryText = (try! String(contentsOf: URL(fileURLWithPath: queryFile))).trimmingCharacters(in: .whitespacesAndNewlines)
            let queryResult = query.executeQuery(queryText)
            let fileText = """
                           Do NOT approve
                               This file will be deleted
                               It is for feedback purposes only

                           query:
                           \(queryText)

                           result:
                           \(queryResult)
                           """
            try! fileText.write(toFile: fileName, atomically: true, encoding: .utf8)
        }
        return fileName
    }
    
    class func wrap(_ options: Options, _ query: ExecutableQuery) throws -> Options {
        let reporter = options.reporter
        let reporter2 = ExecutableReporter(reporter, query)
        return options.with(reporter: reporter2)
    }
}
