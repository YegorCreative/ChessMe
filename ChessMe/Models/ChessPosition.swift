import Foundation

struct ChessPosition: Hashable, Codable {
    let file: Int
    let rank: Int

    var isWithinBoard: Bool {
        (0..<8).contains(file) && (0..<8).contains(rank)
    }

    init(file: Int, rank: Int) {
        self.file = file
        self.rank = rank
    }
}
