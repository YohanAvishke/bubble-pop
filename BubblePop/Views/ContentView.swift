import SwiftUI

struct ContentView: View {
    @State private var playerName = ""
    @State private var isGamePresented = false
    
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
        }
    }
}

#Preview {
    ContentView()
}
