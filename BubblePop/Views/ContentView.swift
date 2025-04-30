import SwiftUI

struct ContentView: View {
    @State private var playerName = ""
    // Flags control the presentation of each screen
    @State private var isGamePresented = false
    @State private var isScoreBoardPresented = false
    @State private var isSettingsPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🎈 Bubble Pop Game 🎈")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter your name", text: $playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Start Game") {
                isGamePresented = true
            }
            .disabled(playerName.isEmpty)
            .buttonStyle(.borderedProminent)
            .fullScreenCover(isPresented: $isGamePresented) {
                GameView(playerName: playerName)
            }
            
            Button("High Scores") {
                isScoreBoardPresented = true
            }
            .buttonStyle(.borderedProminent)
            .fullScreenCover(isPresented: $isScoreBoardPresented) {
                ScoreboardView {
                    // Allows dismissing the screen
                    isScoreBoardPresented = false
                }
            }
            
            Button("⚙️ Settings") {
                isSettingsPresented = true
            }
            .buttonStyle(.bordered)
            .fullScreenCover(isPresented: $isSettingsPresented) {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
