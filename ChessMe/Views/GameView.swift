import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.currentTurnText)
                .font(.headline)

            Text("Chess board coming next.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            ChessBoardView(
                displaySquares: viewModel.displaySquares,
                onSquareTap: viewModel.toggleSelection(at:)
            )
                .frame(maxWidth: 420)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(24)
        .navigationTitle("New Game")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
