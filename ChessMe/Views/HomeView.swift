//
//  ContentView.swift
//  ChessMe
//
//  Created by Yegor Hambaryan on 5/31/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 12) {
                Text("ChessMe")
                    .font(.system(size: 40, weight: .bold, design: .rounded))

                Text("Play. Learn. Improve.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            NavigationLink(destination: GameView()) {
                Text("New Game")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(24)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView()
}
