import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss // used to dismiss the screen
    @State private var gameTime = GameSetting.shared.timeLimit
    @State private var maxBubbles = GameSetting.shared.maxBubbles
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Game Duration")) {
                    // Game time from 10 to 180 seconds with 5 second increments
                    Stepper(value: $gameTime, in: 10...180, step: 5) {
                        Text("\(gameTime) seconds")
                    }
                }
                
                Section(header: Text("Max Bubbles")) {
                    // Max bubbles from 5 to 30
                    Stepper(value: $maxBubbles, in: 5...30) {
                        Text("\(maxBubbles) bubbles")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Persist updated settings back to shared GameSetting
                        GameSetting.shared.timeLimit = gameTime
                        GameSetting.shared.maxBubbles = maxBubbles
                        // Dismiss the screen
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
