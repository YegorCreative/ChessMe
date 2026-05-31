import SwiftUI

struct ChessBoardView: View {
    enum Orientation {
        case whiteAtBottom
        case blackAtBottom
    }

    let orientation: Orientation

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)

    init(orientation: Orientation = .whiteAtBottom) {
        self.orientation = orientation
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
                        ForEach(0..<8, id: \.self) { rank in
                            ForEach(0..<8, id: \.self) { file in
                                BoardSquareView(tone: squareTone(file: file, rank: rank))
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

    private func coordinateLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption2.weight(.medium))
            .foregroundStyle(.secondary)
            .textCase(.lowercase)
    }

    private func squareTone(file: Int, rank: Int) -> BoardSquareView.SquareTone {
        (file + rank).isMultiple(of: 2) ? .light : .dark
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
