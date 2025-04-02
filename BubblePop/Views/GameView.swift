//
//  GameView.swift
//  BubblePop
//
//  Created by Yohan Ediriweera on 2025-04-02.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Time: 60s") // Placeholder
                Spacer()
                Text("Score: 0") // Placeholder
            }
            .padding()
            
            ZStack {
                // Placeholder bubbles
                ForEach(0..<10, id: \.self) { i in
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .position(x: CGFloat.random(in: 50...300), y: CGFloat.random(in: 100...500))
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    GameView()
}
