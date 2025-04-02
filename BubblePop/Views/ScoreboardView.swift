//
//  ScoreboardView.swift
//  BubblePop
//
//  Created by Yohan Ediriweera on 2025-04-02.
//

import SwiftUI

struct ScoreboardView: View {
    let highScores = [
        ("Alice", 150),
        ("Bob", 120)
    ]
    
    var body: some View {
        VStack {
            Text("High Scores")
                .font(.largeTitle)
            
            List(highScores, id: \.0) { entry in
                HStack {
                    Text(entry.0)
                    Spacer()
                    Text("\(entry.1)")
                }
            }
        }
    }
}

#Preview {
    ScoreboardView()
}
