import XCTest

class Failer {
    func fail(_ message: String) throws {
    }
}

class XCTFailer: Failer {
    override func fail(_ message: String) throws {
        XCTFail(message)
    }
}
