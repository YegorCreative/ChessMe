import Foundation

struct BoardSquareDisplayModel: Identifiable, Hashable {
    let position: ChessPosition
    let file: Int
    let rank: Int
    let isLightSquare: Bool
    let piece: ChessPiece?
    let isSelected: Bool

    var pieceSymbol: String? {
        guard let piece else { return nil }

        switch (piece.color, piece.type) {
        case (.white, .king):
            return "♔"
        case (.white, .queen):
            return "♕"
        case (.white, .rook):
            return "♖"
        case (.white, .bishop):
            return "♗"
        case (.white, .knight):
            return "♘"
        case (.white, .pawn):
            return "♙"
        case (.black, .king):
            return "♚"
        case (.black, .queen):
            return "♛"
        case (.black, .rook):
            return "♜"
        case (.black, .bishop):
            return "♝"
        case (.black, .knight):
            return "♞"
        case (.black, .pawn):
            return "♟"
        }
    }

    var id: ChessPosition {
        position
    }

    init(position: ChessPosition, piece: ChessPiece? = nil, isSelected: Bool = false) {
        self.position = position
        self.file = position.file
        self.rank = position.rank
        self.isLightSquare = (position.file + position.rank).isMultiple(of: 2)
        self.piece = piece
        self.isSelected = isSelected
    }

    init(square: ChessBoardSquare, isSelected: Bool = false) {
        self.init(position: square.position, piece: square.piece, isSelected: isSelected)
    }

    static func emptyBoard() -> [BoardSquareDisplayModel] {
        ChessPosition.allBoardPositions.map { position in
            BoardSquareDisplayModel(position: position)
        }
    }
}
