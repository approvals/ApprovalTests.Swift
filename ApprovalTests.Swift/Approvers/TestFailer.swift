import XCTest

protocol Failer {
    func fail(_ message: String) throws
}

class XCTFailer: Failer {
    func fail(_ message: String) throws {
        XCTFail(message)
    }
}
