import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = GameViewModel()
    @State private var showScoreboard = false
    
    let playerName: String
    
    var body: some View {
        ZStack {
            // Countdown before the game
            if viewModel.showCountdown {
                Text(viewModel.countdownText)
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .shadow(radius: 10)
                    .transition(.scale)
            }
            
            // UI for the game
            VStack {
                // Top inforamtion bar
                HStack {
                    Text("Time: \(viewModel.timeLeft)")
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                .padding()
                
                // Game
                ZStack {
                    // Make sure bubbles doesn't overflow
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
                        ForEach(viewModel.comboPopups) { popup in
                            Text(popup.text)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .transition(.scale.combined(with: .opacity))
                                .position(
                                    x: popup.x * geo.size.width,
                                    y: popup.y * geo.size.height
                                )
                        }
                    }
                }
                Spacer()
                
                // Bottom controls
                HStack(spacing: 30) {
                    Button(
                        action: {viewModel.startCountdown(for: playerName)}
                    ) {
                        Label("Restart", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.showCountdown)
                    
                    Spacer()
                    
                    Button(
                        action: {dismiss()}
                    ) {
                        Label("Exit", systemImage: "xmark")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal, 20.0)
            }
            .onAppear {
                viewModel.startCountdown(for: playerName)
            }
            .onChange(of: viewModel.isGameOver) {
                if viewModel.isGameOver {
                    showScoreboard = true
                }
            }
            .fullScreenCover(isPresented: $showScoreboard) {
                ScoreboardView{
                    // Close the GameView when user closes ScoreboardView.
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    GameView(playerName: "Test User")
}
