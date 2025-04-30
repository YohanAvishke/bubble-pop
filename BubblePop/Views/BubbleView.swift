import SwiftUI

struct BubbleView: View {
    // Reference coming from the GameView
    @ObservedObject var gameViewModel: GameViewModel
    // Controls pop animation
    @State private var isAnimatingPop = false
    // Offsets for movements when a bubble pops
    @State private var yOffset: CGFloat = 0
    @State private var xOffset: CGFloat = 0
    
    let bubble: Bubble
    let screenHeight: CGFloat
    
    var body: some View {
        Circle()
            .fill(bubble.isPopping ? Color.gray : bubble.color.color)
            .frame(width: 60, height: 60)
            .shadow(radius: 5)
            .offset(x: xOffset, y: yOffset)
            .opacity(isAnimatingPop ? 0 : 1)
            .animation(.easeInOut(duration: 0.6), value: isAnimatingPop)
            .onTapGesture {
                if !bubble.isPopping {
                    gameViewModel.pop(bubble)
                }
            }
            // When the bubble starts popping, animate it flying off screen
            .onChange(of: bubble.isPopping) {
                if bubble.isPopping {
                    let randomXDirection: CGFloat = Bool.random() ? -1 : 1
                    xOffset = randomXDirection * 100
                    yOffset = screenHeight + 100
                    isAnimatingPop = true
                }
            }
            .allowsHitTesting(!bubble.isPopping) // disable popped bubbles
    }
}
