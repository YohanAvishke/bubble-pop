import SwiftUI

struct ContentView: View {
    @State private var playerName = ""
    @State private var showGame = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🎈 Bubble Pop Game 🎈")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter your name", text: $playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Start Game") {
                showGame = true
            }
            .disabled(playerName.isEmpty)
            .buttonStyle(.borderedProminent)
            .fullScreenCover(isPresented: $showGame) {
                GameView(playerName: playerName)
            }
        }
    }
}

#Preview {
    ContentView()
}
