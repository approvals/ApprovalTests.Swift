import XCTest

public protocol Failer {
    func fail(_ message: String, file: StaticString, line: UInt) throws
}

public struct XCTFailer: Failer {
    public func fail(_ message: String, file: StaticString, line: UInt) throws {
        XCTFail(message, file: file, line: line)
    }
}
