import Foundation

struct ChessGame {
    var boardState: ChessBoardState
    var currentTurn: ChessPieceColor

    init(
        boardState: ChessBoardState = .standardSetup(),
        currentTurn: ChessPieceColor = .white
    ) {
        self.boardState = boardState
        self.currentTurn = currentTurn
    }
}
