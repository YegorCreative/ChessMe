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
              RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.accentColor, lineWidth: 3)
                .padding(4)
            }
          }
          .overlay {
                if let pieceSymbol {
                    Text(pieceSymbol)
                        .font(.system(size: 28))
                        .foregroundStyle(.primary)
                }
            }
            .accessibilityHidden(true)
    }
}

#Preview("Board Squares") {
    VStack(spacing: 0) {
        HStack(spacing: 0) {
            BoardSquareView(tone: .light)
            BoardSquareView(tone: .dark)
        }
        HStack(spacing: 0) {
            BoardSquareView(tone: .dark)
            BoardSquareView(tone: .light)
        }
    }
    .frame(width: 140)
    .padding()
}
