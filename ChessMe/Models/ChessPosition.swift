import Foundation

struct ChessPosition: Hashable, Codable {
    let file: Int
    let rank: Int

    static let boardDimension = 8

    static var allBoardPositions: [ChessPosition] {
        (0..<boardDimension).flatMap { rank in
            (0..<boardDimension).map { file in
                ChessPosition(file: file, rank: rank)
            }
        }
    }

    var isWithinBoard: Bool {
        (0..<Self.boardDimension).contains(file) && (0..<Self.boardDimension).contains(rank)
    }

    init(file: Int, rank: Int) {
        self.file = file
        self.rank = rank
    }
}
