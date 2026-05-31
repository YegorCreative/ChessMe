import Foundation

enum ChessPieceColor: String, CaseIterable, Codable {
    case white
    case black
}

enum ChessPieceType: String, CaseIterable, Codable {
    case king
    case queen
    case rook
    case bishop
    case knight
    case pawn
}

struct ChessPiece: Identifiable, Equatable, Codable {
    let id: UUID
    let type: ChessPieceType
    let color: ChessPieceColor

    init(id: UUID = UUID(), type: ChessPieceType, color: ChessPieceColor) {
        self.id = id
        self.type = type
        self.color = color
    }
}
