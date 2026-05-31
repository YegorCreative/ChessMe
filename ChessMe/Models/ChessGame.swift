import Foundation

struct ChessGame {
    var pieces: [ChessPiece]
    var selectedPosition: ChessPosition?
    var currentTurn: ChessPieceColor

    init(
        pieces: [ChessPiece] = [],
        selectedPosition: ChessPosition? = nil,
        currentTurn: ChessPieceColor = .white
    ) {
        self.pieces = pieces
        self.selectedPosition = selectedPosition
        self.currentTurn = currentTurn
    }
}
