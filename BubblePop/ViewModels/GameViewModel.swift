import SwiftUI

class GameViewModel: ObservableObject {
    @Published var showCountdown = false
    @Published var countdownText = "3"
    @Published var bubbles: [Bubble] = []
    @Published var score = 0
    @Published var isGameOver = false
    @Published var maxBubbles = GameSettings.shared.maxBubbles
    @Published var timeLeft = GameSettings.shared.timeLimit
    
    var lastPoppedColor: BubbleColor?
    var playerName = ""
    var timer: Timer?
    var comboCount = 0
    
    func resetGameState() {
        countdownText = "3"
        timer?.invalidate()
        timer = nil
        bubbles = []
        score = 0
        timeLeft = GameSettings.shared.timeLimit
        isGameOver = false
        lastPoppedColor = nil
    }
    
    func startCountdown(for name: String) {
        // Prevent countdown if already running
        if showCountdown { return }
        
        resetGameState()
        
        playerName = name
        showCountdown = true
        
        let sequence = ["3", "2", "1", "Start!"]
        for (index, value) in sequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.countdownText = value
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(sequence.count)) {
            self.showCountdown = false
            self.startGame(for: name)
        }
    }
    
    func startGame(for name: String) {
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
        // All the bubbles are spawned in pre-defined cells to stop overlapping issues
        var newBubbles: [Bubble] = []
        let count = Int.random(in: 1...maxBubbles)
        let rows = 8
        let cols = 5
        
        // Define the cells
        var availableCells: [(row: Int, col: Int)] = []
        for r in 0..<rows {
            for c in 0..<cols {
                availableCells.append((r, c))
            }
        }
        
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
                comboCount += 1
            } else {
                comboCount = 0
            }
            
            let awardedPoints: Int
            if comboCount > 0 {
                awardedPoints = Int(round(Double(basePoints) * 1.5))
            } else {
                awardedPoints = basePoints
            }
            
            score += awardedPoints
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
