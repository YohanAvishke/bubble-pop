// Views/GameView.swift

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = GameViewModel()
    let playerName: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Time: \(viewModel.timeLeft)")
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                .padding()
                
                ZStack {
                    ForEach(viewModel.bubbles) { bubble in
                        BubbleView(bubble: bubble)
                            .position(x: bubble.x * UIScreen.main.bounds.width,
                                      y: bubble.y * UIScreen.main.bounds.height)
                            .onTapGesture {
                                viewModel.pop(bubble)
                            }
                    }
                }
                
                Spacer()
            }
            .blur(radius: viewModel.isGameOver ? 5 : 0)
            
            if viewModel.isGameOver {
                ScoreboardView()
            }
        }
        .onAppear {
            viewModel.startGame(for: playerName)
        }
    }
}

#Preview {
    GameView(playerName: "Test User")
}
