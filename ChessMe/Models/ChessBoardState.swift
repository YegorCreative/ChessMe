import Foundation

struct ChessBoardSquare: Identifiable, Hashable {
    let position: ChessPosition
    var piece: ChessPiece?

    var id: ChessPosition {
        position
    }
}

struct ChessBoardState {
    private(set) var squares: [ChessBoardSquare]

    init() {
        self.init(pieceMap: [:])
    }

    init(pieceMap: [ChessPosition: ChessPiece]) {
        squares = ChessPosition.allBoardPositions.map { position in
            ChessBoardSquare(position: position, piece: pieceMap[position])
        }
    }

    static func standardSetup() -> ChessBoardState {
        var pieceMap: [ChessPosition: ChessPiece] = [:]

        let backRank: [ChessPieceType] = [
            .rook, .knight, .bishop, .queen,
            .king, .bishop, .knight, .rook,
        ]

        for file in 0..<ChessPosition.boardDimension {
            pieceMap[ChessPosition(file: file, rank: 0)] = ChessPiece(type: backRank[file], color: .white)
            pieceMap[ChessPosition(file: file, rank: 1)] = ChessPiece(type: .pawn, color: .white)
            pieceMap[ChessPosition(file: file, rank: 6)] = ChessPiece(type: .pawn, color: .black)
            pieceMap[ChessPosition(file: file, rank: 7)] = ChessPiece(type: backRank[file], color: .black)
        }

        return ChessBoardState(pieceMap: pieceMap)
    }

    var squareCount: Int {
        squares.count
    }

    var occupiedSquareCount: Int {
        squares.filter { $0.piece != nil }.count
    }

    func square(at position: ChessPosition) -> ChessBoardSquare? {
        squares.first { $0.position == position }
    }

    func piece(at position: ChessPosition) -> ChessPiece? {
        square(at: position)?.piece
    }

    func pieceMap() -> [ChessPosition: ChessPiece] {
        squares.reduce(into: [:]) { result, square in
            guard let piece = square.piece else { return }
            result[square.position] = piece
        }
    }

    mutating func movePiece(from source: ChessPosition, to destination: ChessPosition) {
        guard source != destination,
              let piece = piece(at: source)
        else {
            return
        }

        setPiece(nil, at: source)
        setPiece(piece, at: destination)
    }

    private mutating func setPiece(_ piece: ChessPiece?, at position: ChessPosition) {
        guard let index = squares.firstIndex(where: { $0.position == position }) else {
            return
        }

        squares[index].piece = piece
    }
}
