import SwiftUI

struct ScoreboardView: View {
    @Environment(\.dismiss) var dismiss
    var onQuit: () -> Void
    
    var scores: [String] {
        UserDefaults.standard.stringArray(forKey: "HighScores")?.sorted(by: { $0 > $1 }) ?? []
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("🎉 Game Over 🎉").font(.largeTitle)
            Text("🏆 High Scores").font(.title2)
            
            List(scores.prefix(10), id: \.self) { score in
                Text(score)
            }
            
            Button("Play Again") {
                onQuit()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ScoreboardView(onQuit:{
        print("Back to Menu tapped (Preview)")
    })
}
