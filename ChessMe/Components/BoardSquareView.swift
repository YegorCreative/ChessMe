import SwiftUI

struct BoardSquareView: View {
    enum SquareTone {
        case light
        case dark

        var color: Color {
            switch self {
            case .light:
                return Color(red: 0.93, green: 0.89, blue: 0.82)
            case .dark:
                return Color(red: 0.60, green: 0.45, blue: 0.34)
            }
        }
    }

    let tone: SquareTone
    let pieceSymbol: String?
    let isSelected: Bool

    init(tone: SquareTone, pieceSymbol: String? = nil, isSelected: Bool = false) {
        self.tone = tone
        self.pieceSymbol = pieceSymbol
        self.isSelected = isSelected
    }

    var body: some View {
        Rectangle()
            .fill(tone.color)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.accentColor.opacity(0.95), lineWidth: 3)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.accentColor.opacity(0.10))
                        )
                        .padding(4)
                }
            }
            .overlay {
                if let pieceSymbol {
                    Text(pieceSymbol)
                        .font(.system(size: 30, weight: .medium, design: .default))
                        .foregroundStyle(.primary)
                        .shadow(color: Color.black.opacity(0.08), radius: 1, x: 0, y: 1)
                }
            }
            .accessibilityHidden(true)
    }
}

#Preview("Board Squares") {
    VStack(spacing: 0) {
        HStack(spacing: 0) {
            BoardSquareView(tone: .light, pieceSymbol: "♔", isSelected: true)
            BoardSquareView(tone: .dark, pieceSymbol: "♛")
        }
        HStack(spacing: 0) {
            BoardSquareView(tone: .dark)
            BoardSquareView(tone: .light)
        }
    }
    .frame(width: 140)
    .padding()
}
