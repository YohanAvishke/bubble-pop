import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    // Model to manages game logic and state
    @StateObject private var viewModel = GameViewModel()
    // Is the scoreboard presented?
    @State private var showScoreboard = false
    
    let playerName: String
    
    var body: some View {
        ZStack {
            // Countdown overlay at the start of the game
            if viewModel.showCountdown {
                Text(viewModel.countdownText)
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                    .background(.ultraThinMaterial)
                    .shadow(radius: 10)
                    .transition(.scale)
            }
            
            // Main UI stack for gameplay
            VStack {
                HStack { // top inforamtion stack
                    Text("Time: \(viewModel.timeLeft)")
                    Spacer()
                    Text("High Score: \(HighScoreManager.fetchHighestScore())")
                    Spacer()
                    Text("Score: \(viewModel.score)")
                }
                .padding()
                
                ZStack { // game stack
                    // Used to get screen size for positioning bubbles
                    GeometryReader { geo in
                        let width = geo.size.width
                        let height = geo.size.height
                        
                        // Display bubbles
                        ForEach(viewModel.bubbles) { bubble in
                            BubbleView(gameViewModel: self.viewModel,
                                       bubble: bubble,
                                       screenHeight: height)
                            .position(x: bubble.x * width,
                                      y: bubble.y * height)
                        }
                        // Show combo popups relatively
                        ForEach(viewModel.comboPopups) { popup in
                            Text(popup.text)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .transition(.scale.combined(with: .opacity))
                                .position(
                                    x: popup.x * width,
                                    y: popup.y * height
                                )
                        }
                    }
                }
                Spacer()
                
                // Bottom control buttons
                HStack(spacing: 30) {
                    // Restart button
                    Button(action:
                            {viewModel.startCountdown(for: playerName)}
                    ) {
                        Label("Restart", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.showCountdown)
                    Spacer()
                    // Exit button
                    Button(action:
                            {dismiss()}
                    ) {
                        Label("Exit", systemImage: "xmark")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal, 20.0)
            }
            .onAppear {
                // Start game
                viewModel.startCountdown(for: playerName)
            }
            // Display ScoreboardView full screen when game ends
            .onChange(of: viewModel.isGameOver) {
                if viewModel.isGameOver {
                    showScoreboard = true
                }
            }
            .fullScreenCover(isPresented: $showScoreboard) {
                ScoreboardView {
                    // Close the GameView when user closes ScoreboardView
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    GameView(playerName: "Test User")
}
