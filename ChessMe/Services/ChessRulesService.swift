import Foundation

struct ChessRulesService {
    let placeholderMessage = "Chess rules are not implemented yet."

    func isLegalPawnMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .pawn,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let direction = piece.color == .white ? 1 : -1
        let startingRank = piece.color == .white ? 1 : 6
        let rankDelta = destination.rank - source.rank
        let fileDelta = destination.file - source.file
        let destinationPiece = boardState.piece(at: destination)

        if fileDelta == 0 {
            guard destinationPiece == nil else {
                return false
            }

            if rankDelta == direction {
                return true
            }

            if source.rank == startingRank && rankDelta == 2 * direction {
                let intermediatePosition = ChessPosition(file: source.file, rank: source.rank + direction)
                return boardState.piece(at: intermediatePosition) == nil
            }

            return false
        }

        if abs(fileDelta) == 1 && rankDelta == direction {
            guard let destinationPiece else {
                return false
            }

            return destinationPiece.color != piece.color
        }

        return false
    }
}
