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

    func isLegalKnightMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .knight,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let fileDelta = abs(destination.file - source.file)
        let rankDelta = abs(destination.rank - source.rank)
        let isLShapeMove = (fileDelta == 2 && rankDelta == 1) || (fileDelta == 1 && rankDelta == 2)

        guard isLShapeMove else {
            return false
        }

        guard let destinationPiece = boardState.piece(at: destination) else {
            return true
        }

        return destinationPiece.color != piece.color
    }

    func isLegalBishopMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .bishop,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let fileDelta = abs(destination.file - source.file)
        let rankDelta = abs(destination.rank - source.rank)

        guard fileDelta == rankDelta else {
            return false
        }

        guard isPathClear(from: source, to: destination, on: boardState) else {
            return false
        }

        guard let destinationPiece = boardState.piece(at: destination) else {
            return true
        }

        return destinationPiece.color != piece.color
    }

    func isLegalRookMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .rook,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let sameFile = source.file == destination.file
        let sameRank = source.rank == destination.rank

        guard sameFile || sameRank else {
            return false
        }

        guard isPathClear(from: source, to: destination, on: boardState) else {
            return false
        }

        guard let destinationPiece = boardState.piece(at: destination) else {
            return true
        }

        return destinationPiece.color != piece.color
    }

    func isLegalQueenMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .queen,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let fileDelta = abs(destination.file - source.file)
        let rankDelta = abs(destination.rank - source.rank)
        let sameFile = source.file == destination.file
        let sameRank = source.rank == destination.rank
        let isDiagonal = fileDelta == rankDelta
        let isStraightLine = sameFile || sameRank

        guard isDiagonal || isStraightLine else {
            return false
        }

        guard isPathClear(from: source, to: destination, on: boardState) else {
            return false
        }

        guard let destinationPiece = boardState.piece(at: destination) else {
            return true
        }

        return destinationPiece.color != piece.color
    }

    func isLegalKingMove(
        for piece: ChessPiece,
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        guard piece.type == .king,
              source != destination,
              destination.isWithinBoard
        else {
            return false
        }

        let fileDelta = abs(destination.file - source.file)
        let rankDelta = abs(destination.rank - source.rank)

        guard fileDelta <= 1,
              rankDelta <= 1,
              !(fileDelta == 0 && rankDelta == 0)
        else {
            return false
        }

        guard let destinationPiece = boardState.piece(at: destination) else {
            return true
        }

        return destinationPiece.color != piece.color
    }

    private func isPathClear(
        from source: ChessPosition,
        to destination: ChessPosition,
        on boardState: ChessBoardState
    ) -> Bool {
        let fileStep = stepValue(from: source.file, to: destination.file)
        let rankStep = stepValue(from: source.rank, to: destination.rank)

        var currentFile = source.file + fileStep
        var currentRank = source.rank + rankStep

        while currentFile != destination.file || currentRank != destination.rank {
            let currentPosition = ChessPosition(file: currentFile, rank: currentRank)

            if boardState.piece(at: currentPosition) != nil {
                return false
            }

            currentFile += fileStep
            currentRank += rankStep
        }

        return true
    }

    private func stepValue(from start: Int, to end: Int) -> Int {
        if end > start {
            return 1
        }

        if end < start {
            return -1
        }

        return 0
    }
}
