//
//  ContentView.swift
//  BubblePop
//
//  Created by Yohan Ediriweera on 2025-04-02.
//

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to BubblePop")
                .font(.largeTitle)
            
            TextField("Enter your name", text: $playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Start Game") {
                // Navigation logic later
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
