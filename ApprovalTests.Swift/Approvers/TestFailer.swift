import XCTest

public protocol Failer {
    func fail(_ message: String, file: StaticString, line: UInt) throws
}

struct XCTFailer: Failer {
    func fail(_ message: String, file: StaticString, line: UInt) throws {
        XCTFail(message, file: file, line: line)
    }
}
