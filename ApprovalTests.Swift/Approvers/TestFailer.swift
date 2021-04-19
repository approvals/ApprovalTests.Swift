import XCTest

protocol Failer {
    func fail(_ message: String, file: StaticString, line: UInt) throws
}

class XCTFailer: Failer {
    func fail(_ message: String, file: StaticString, line: UInt) throws {
        XCTFail(message, file: file, line: line)
    }
}
