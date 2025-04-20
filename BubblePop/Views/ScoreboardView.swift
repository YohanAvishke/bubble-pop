import SwiftUI

struct ScoreboardView: View {
    var onClose: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            Text("🏆 High Scores").font(.largeTitle)
            
            List(HighScoreManager.fetchAllSortedbyHighest().prefix(10),
                 id: \.self) {
                score in Text(score)
            }
            
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
    ScoreboardView(onClose:{
        print("Back to Menu tapped")
    })
}
