import SwiftUI

struct ScoreboardView: View {
    /*
     Optional, to handle closing the scoreboard. Only not null when this view
     is presented through the GameView
     */
    var onClose: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            Text("🏆 High Scores").font(.largeTitle)
            // Sort and fetch scores
            List(
                HighScoreManager.fetchAllSortedbyHighest().prefix(10),
                id: \.self
            ) {
                score in Text(score)
            }
            // Exit button
            if let onClose = onClose {
                Button("Close") {
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
        }
        .padding()
    }
}

#Preview {
    ScoreboardView(onClose:{print("Closed ScoreboardView")})
}
