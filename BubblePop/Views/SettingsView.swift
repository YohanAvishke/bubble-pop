import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var gameTime = GameSetting.shared.timeLimit
    @State private var maxBubbles = GameSetting.shared.maxBubbles
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Game Duration")) {
                    Stepper(value: $gameTime, in: 10...180, step: 5) {
                        Text("\(gameTime) seconds")
                    }
                }
                
                Section(header: Text("Max Bubbles")) {
                    Stepper(value: $maxBubbles, in: 5...30) {
                        Text("\(maxBubbles) bubbles")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        GameSetting.shared.timeLimit = gameTime
                        GameSetting.shared.maxBubbles = maxBubbles
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    SettingsView()
}
