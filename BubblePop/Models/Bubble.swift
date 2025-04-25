import SwiftUI

enum BubbleColor: CaseIterable {
    case red, pink, green, blue, black
    
    var color: Color {
        switch self {
            case .red: return .red
            case .pink: return .pink
            case .green: return .green
            case .blue: return .blue
            case .black: return .black
        }
    }
    
    var points: Int {
        switch self {
            case .red: return 1
            case .pink: return 2
            case .green: return 5
            case .blue: return 8
            case .black: return 10
        }
    }
    
    static func randomByProbability() -> BubbleColor {
        let rand = Double.random(in: 0...1)
        switch rand {
            case 0..<0.4: return .red
            case 0.4..<0.7: return .pink
            case 0.7..<0.85: return .green
            case 0.85..<0.95: return .blue
            default: return .black
        }
    }
}

struct Bubble: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var color: BubbleColor
    var isPopping = false
    
    static func generateBubbles(
        max: Int, rows: Int = 8, cols: Int = 5) -> [Bubble] {
        var newBubbles: [Bubble] = []
        let count = Int.random(in: 1...max)
        var availableCells: [(row: Int, col: Int)] =
            (0..<rows).flatMap { r in (0..<cols).map { c in (r, c) } }
        availableCells.shuffle()
        
        for cell in availableCells.prefix(count) {
            let cellWidth = 1.0 / CGFloat(cols)
            let cellHeight = 1.0 / CGFloat(rows)
            let x = (CGFloat(cell.col) + 0.5) * cellWidth
            let y = (CGFloat(cell.row) + 0.5) * cellHeight
            let bubble = Bubble(
                x: x,
                y: y,
                color: BubbleColor.randomByProbability()
            )
            newBubbles.append(bubble)
        }
        
        return newBubbles
    }
}
