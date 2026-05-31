import Foundation
import Combine

final class GameViewModel: ObservableObject {
    @Published private(set) var game = ChessGame()
    @Published private(set) var selectedPosition: ChessPosition?

    private let rulesService: ChessRulesService

    var boardState: ChessBoardState {
        game.boardState
    }

    var displaySquares: [BoardSquareDisplayModel] {
        boardState.squares.map { square in
            BoardSquareDisplayModel(square: square, isSelected: square.position == selectedPosition)
        }
    }

    var boardSquareCount: Int {
        boardState.squareCount
    }

    var currentTurnText: String {
        game.currentTurn == .white ? "White to move" : "Black to move"
    }

    func toggleSelection(at position: ChessPosition) {
        if selectedPosition == position {
            selectedPosition = nil
        } else if let selectedPosition {
            moveSelectedPiece(to: position, from: selectedPosition)
        } else {
            guard let piece = boardState.piece(at: position), piece.color == game.currentTurn else {
                return
            }

            selectedPosition = position
        }
    }

    private func moveSelectedPiece(to destination: ChessPosition, from source: ChessPosition) {
        guard let selectedPiece = boardState.piece(at: source) else {
            selectedPosition = nil
            return
        }

        if selectedPiece.type == .pawn {
            guard rulesService.isLegalPawnMove(for: selectedPiece, from: source, to: destination, on: boardState) else {
                return
            }
        }

        var updatedGame = game
        updatedGame.boardState.movePiece(from: source, to: destination)
        updatedGame.currentTurn = updatedGame.currentTurn.nextTurn
        game = updatedGame
        selectedPosition = nil
    }

    var statusText: String {
        rulesService.placeholderMessage + " " + "White to move first."
    }

    init(rulesService: ChessRulesService = ChessRulesService()) {
        self.rulesService = rulesService
    }
}
