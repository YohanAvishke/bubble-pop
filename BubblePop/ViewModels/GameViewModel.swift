// ViewModels/GameViewModel.swift

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score = 0
    @Published var timeLeft = 60
    @Published var isGameOver = false
    
    let maxBubbles = 15
    var lastPoppedColor: BubbleColor?
    var playerName = ""
    var timer: Timer?
    
    func startGame(for name: String) {
        playerName = name
        score = 0
        timeLeft = 60
        bubbles = []
        isGameOver = false
        lastPoppedColor = nil
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
        spawnBubbles()
    }
    
    func tick() {
        if timeLeft == 0 {
            timer?.invalidate()
            isGameOver = true
            saveHighScore()
        } else {
            timeLeft -= 1
            spawnBubbles()
        }
    }
    
    func spawnBubbles() {
        var newBubbles: [Bubble] = []
        let count = Int.random(in: 1...maxBubbles)
        
        let rows = 8
        let cols = 5
        
        // Generate all possible cell coordinates
        var availableCells: [(row: Int, col: Int)] = []
        for r in 0..<rows {
            for c in 0..<cols {
                availableCells.append((r, c))
            }
        }
        
        // Shuffle and pick up to maxBubbles cells
        availableCells.shuffle()
        let selectedCells = availableCells.prefix(count)
        
        for cell in selectedCells {
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
        
        bubbles = newBubbles
    }

    
    func pop(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
            
            let basePoints = bubble.color.points
            if lastPoppedColor == bubble.color {
                score += Int(round(Double(basePoints) * 1.5))
            } else {
                score += basePoints
            }
            lastPoppedColor = bubble.color
        }
    }
    
    func saveHighScore() {
        let entry = "\(playerName): \(score)"
        var existing = UserDefaults.standard.stringArray(forKey: "HighScores") ?? []
        existing.append(entry)
        UserDefaults.standard.set(existing, forKey: "HighScores")
    }
}
