import SwiftUI

struct BubbleView: View {
    let bubble: Bubble
    
    var body: some View {
        Circle()
            .fill(bubble.color.color)
            .frame(width: 60, height: 60)
            .shadow(radius: 5)
    }
}
