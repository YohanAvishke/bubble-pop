import SwiftUI

struct BubbleView: View {
    @ObservedObject var gameViewModel : GameViewModel

    let bubble: Bubble
    
    var body: some View {
        Circle()
            .fill(bubble.color.color)
            .frame(width: 60, height: 60)
            .shadow(radius: 5)
            .onTapGesture {
                gameViewModel.pop(bubble)
            }
    }
}

#Preview {
    BubbleView(gameViewModel: GameViewModel(),
               bubble: Bubble(x: 10, y: 10, color: BubbleColor.blue))
}
