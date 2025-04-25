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
    
    /// Used to randomise the bubble types.
    /// Red 40%, Pink 30%, Green 15%, Blue 10%, Black 5% chance of appearing
    /// - Returns: colour of the bubble type
    static func randomByProbability() -> BubbleColor {
        let probability = Double.random(in: 0...1)
        switch probability {
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
    var isPopping = false // flag to track a popped bubble from a non-popped one
    
    
    /// Bubbble geenration logic
    /// - Parameters:
    ///   - maxBubbles: maximum number of genratable bubbles
    ///   - rowCount: screen in divided to 8 rows
    ///   - columnCount: screen in divided to 5 columns
    /// - Returns: generated bubbles
    static func generateBubbles(maxBubbles: Int,
                                rowCount: Int = 8,
                                columnCount: Int = 5) -> [Bubble] {
        var newBubbles: [Bubble] = []
        let bubbleCount = Int.random(in: 1...maxBubbles)
        // Bubbles are randomly generated in pre-defined columns and rows.
        // Which helps to stop bubble overlapping
        var availableCells: [(row: Int, column: Int)] = (0..<rowCount).flatMap {
            r in (0..<columnCount).map { c in (r, c) }
        }
        // Each time generated bubbles should be in different positions
        availableCells.shuffle()
        
        for cell in availableCells.prefix(bubbleCount) {
            // Use the cells to determine each bubble's position
            let cellWidth = 1.0 / CGFloat(columnCount)
            let cellHeight = 1.0 / CGFloat(rowCount)
            let x = (CGFloat(cell.column) + 0.5) * cellWidth
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
