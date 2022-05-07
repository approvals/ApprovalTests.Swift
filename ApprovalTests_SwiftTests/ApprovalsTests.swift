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
        var gameOfLife = GameOfLife { x, y in
            x >= 2 && x <= 4 && y == 2
        }
        try Approvals.verifySequence(gameOfLife, numberOfFrames: 2) { _ in
            gameOfLife = gameOfLife.advance
            return gameOfLife
        }
    }

    func testExecutableQuery() throws {
        try Approvals.verifyQuery(MetMuseumPieceLoader(45734))
    }
}

class MetMuseumPieceLoader: ExecutableQuery {
    private let artID: Int

    init(_ artID: Int) throws {
        self.artID = artID
    }

    func getQuery() -> String {
        "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(artID)"
    }

    func executeQuery(_ query: String) -> String {
        if query.isEmpty {
            return ""
        }
        return NetUtils.readURL(query).replacingOccurrences(matchingPattern: ",") { _ in ",\n" }
    }
}

private struct MyRect: Encodable {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

private class GameOfLife {
    private var board: (Int, Int) -> Bool

    init(_ board: @escaping (Int, Int) -> Bool) {
        self.board = board
    }

    var advance: GameOfLife {
        GameOfLife { [self] x, y in
            let neighbors = [
                board(x - 1, y - 1),
                board(x - 0, y - 1),
                board(x + 1, y - 1),
                board(x - 1, y),
//              board(x - 0, y),
                board(x + 1, y),
                board(x - 1, y + 1),
                board(x - 0, y + 1),
                board(x + 1, y + 1),
            ]
            let cellCount = neighbors.filter { $0 }.count
            return cellCount == 3 || (cellCount == 2 && board(x, y))
        }
    }
}

extension GameOfLife: CustomStringConvertible {
    var description: String {
        StringUtils.printGrid(width: 5, height: 5) { x, y in
            board(x, y) ? "X " : ". "
        }
    }
}
