import Foundation

enum ChessPieceColor: String, CaseIterable, Codable, Hashable {
    case white
    case black

    var nextTurn: ChessPieceColor {
        switch self {
        case .white:
            return .black
        case .black:
            return .white
        }
    }
}

enum ChessPieceType: String, CaseIterable, Codable, Hashable {
    case king
    case queen
    case rook
    case bishop
    case knight
    case pawn
}

struct ChessPiece: Identifiable, Equatable, Codable, Hashable {
    let id: UUID
    let type: ChessPieceType
    let color: ChessPieceColor

    init(id: UUID = UUID(), type: ChessPieceType, color: ChessPieceColor) {
        self.id = id
        self.type = type
        self.color = color
    }
}
