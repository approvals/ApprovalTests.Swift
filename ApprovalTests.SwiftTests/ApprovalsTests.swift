#if os(OSX)
    @testable import ApprovalTests_Swift
#elseif os(iOS)
    @testable import ApprovalTests_iOS
#endif
import XCTest

final class ApprovalsTests: XCTestCase {

    func testToString() throws {
        try Approvals.verify(CGRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testAsJson() throws {
        try Approvals.verifyAsJSON(CGRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testAsJsonWithCustomObject() throws {
        try Approvals.verifyAsJSON(MyRect(x: 5, y: 10, width: 100, height: 200))
    }

    func testSequence() throws {
        var gameOfLife = GameOfLife({ (x: Int, y: Int) in
            return 2 <= x && x <= 4 && y == 2
        })
        try Approvals.verifySequence(gameOfLife, 2, { (f: Int) in
            gameOfLife = gameOfLife.advance()
            return gameOfLife
        })
    }

}

private struct MyRect: Codable {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

private class GameOfLife: CustomStringConvertible {
    private var board: (Int, Int) -> Bool

    init(_ board: @escaping (Int, Int) -> Bool) {
        self.board = board
    }

    func advance() -> GameOfLife {
        return GameOfLife({ (x, y) in
            let c = [
                self.board(x - 1, y - 1),
                self.board(x - 0, y - 1),
                self.board(x + 1, y - 1),
                self.board(x - 1, y),
//                self.board(x - 0, y),
                self.board(x + 1, y),
                self.board(x - 1, y + 1),
                self.board(x - 0, y + 1),
                self.board(x + 1, y + 1),
            ].filter({ b in b }).count
            return c == 3 || (c == 2 && self.board(x, y))
        })
    }

    var description: String {
        return StringUtils.printGrid(5, 5, { (x: Int, y: Int) in
            return board(x, y) ? "X " : ". "
        })
    }
}
