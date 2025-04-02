//
//  SettingsView.swift
//  BubblePop
//
//  Created by Yohan Ediriweera on 2025-04-02.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("gameDuration") var gameDuration = 60
    @AppStorage("maxBubbles") var maxBubbles = 15
    
    var body: some View {
        Form {
            Stepper("Game Time (seconds): \(gameDuration)", value: $gameDuration, in: 10...300)
            Stepper("Max Bubbles: \(maxBubbles)", value: $maxBubbles, in: 5...50)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
