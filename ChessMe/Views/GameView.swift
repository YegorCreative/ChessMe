import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerView

                boardSection
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ChessMe")
                .font(.system(size: 28, weight: .bold, design: .rounded))

            Text(viewModel.currentTurnText)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Text("Classic board play with clean controls and focused move validation.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var boardSection: some View {
        VStack(spacing: 18) {
            ChessBoardView(
                displaySquares: viewModel.displaySquares,
                onSquareTap: viewModel.toggleSelection(at:)
            )
            .frame(maxWidth: 420)

            Text("Tap a piece to select it, then tap a destination square to move.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 10)
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
