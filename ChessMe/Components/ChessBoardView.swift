import SwiftUI

struct ChessBoardView: View {
    enum Orientation {
        case whiteAtBottom
        case blackAtBottom
    }

    let orientation: Orientation
    let displaySquares: [BoardSquareDisplayModel]
    let onSquareTap: (ChessPosition) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)

    init(
        orientation: Orientation = .whiteAtBottom,
        displaySquares: [BoardSquareDisplayModel] = BoardSquareDisplayModel.emptyBoard(),
        onSquareTap: @escaping (ChessPosition) -> Void = { _ in }
    ) {
        self.orientation = orientation
        self.displaySquares = displaySquares
        self.onSquareTap = onSquareTap
    }

    var body: some View {
        GeometryReader { geometry in
            let availableSize = min(geometry.size.width, geometry.size.height)
            let coordinateSize = min(max(availableSize * 0.06, 18), 24)
            let boardSize = max(availableSize - coordinateSize, 0)
            let squareSize = boardSize / 8

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        ForEach(displayedRanks, id: \.self) { rank in
                            coordinateLabel("\(rank)")
                                .frame(width: coordinateSize, height: squareSize)
                        }
                    }

                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(orderedDisplaySquares) { square in
                            BoardSquareView(
                                tone: square.isLightSquare ? .light : .dark,
                                pieceSymbol: square.pieceSymbol,
                                isSelected: square.isSelected
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onSquareTap(square.position)
                            }
                        }
                    }
                    .frame(width: boardSize, height: boardSize)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                    }
                }

                HStack(spacing: 0) {
                    Color.clear
                        .frame(width: coordinateSize, height: coordinateSize)

                    HStack(spacing: 0) {
                        ForEach(displayedFiles, id: \.self) { file in
                            coordinateLabel(file)
                                .frame(width: squareSize, height: coordinateSize)
                        }
                    }
                    .frame(width: boardSize)
                }
            }
            .frame(width: boardSize + coordinateSize, height: boardSize + coordinateSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .accessibilityLabel("Chess board with coordinates")
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private var displayedFiles: [String] {
        switch orientation {
        case .whiteAtBottom:
            return Array("abcdefgh").map(String.init)
        case .blackAtBottom:
            return Array("hgfedcba").map(String.init)
        }
    }

    private var displayedRanks: [Int] {
        switch orientation {
        case .whiteAtBottom:
            return Array((1...8).reversed())
        case .blackAtBottom:
            return Array(1...8)
        }
    }

    private var orderedDisplaySquares: [BoardSquareDisplayModel] {
        let sortedRanks: [Int]
        let sortedFiles: [Int]

        switch orientation {
        case .whiteAtBottom:
            sortedRanks = Array((0..<ChessPosition.boardDimension).reversed())
            sortedFiles = Array(0..<ChessPosition.boardDimension)
        case .blackAtBottom:
            sortedRanks = Array(0..<ChessPosition.boardDimension)
            sortedFiles = Array((0..<ChessPosition.boardDimension).reversed())
        }

        return sortedRanks.flatMap { rank in
            sortedFiles.compactMap { file in
                displaySquares.first { $0.file == file && $0.rank == rank }
            }
        }
    }

    private func coordinateLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption2.weight(.medium))
            .foregroundStyle(.secondary)
            .textCase(.lowercase)
    }

}

#Preview("Chess Board") {
    ChessBoardView()
        .frame(width: 360)
        .padding()
}

#Preview("Chess Board Black Bottom") {
    ChessBoardView(orientation: .blackAtBottom)
        .frame(width: 360)
        .padding()
}

#Preview("Chess Board Compact") {
    ChessBoardView()
        .frame(width: 280)
        .padding()
}
