import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = GameViewModel()
    @State private var showScoreboard = false
    let playerName: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Time: \(viewModel.timeLeft)")
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .padding()
            
            ZStack {
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    
                    ForEach(viewModel.bubbles) { bubble in
                        BubbleView(bubble: bubble)
                            .position(x: bubble.x * width,
                                      y: bubble.y * height)
                            .onTapGesture {
                                viewModel.pop(bubble)
                            }
                    }
                }
            }
            
            Spacer()
            
            HStack(spacing: 30) {
                Button(action: {
                    viewModel.startGame(for: playerName)
                }) {
                    Label("Restart", systemImage: "arrow.clockwise")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Label("Exit", systemImage: "xmark")
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal, 20.0)
            
        }
        .onAppear {
            viewModel.startGame(for: playerName)
        }
        .onChange(of: viewModel.isGameOver) {
            if viewModel.isGameOver {
                showScoreboard = true
            }
        }
        .fullScreenCover(isPresented: $showScoreboard) {
            ScoreboardView(onQuit: {
                dismiss()
            })
        }
    }
}

#Preview {
    GameView(playerName: "Test User")
}
