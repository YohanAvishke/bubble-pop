import SwiftUI

class GameViewModel: ObservableObject {
    @Published var showCountdown = false
    @Published var countdownText = "3"
    @Published var bubbles: [Bubble] = []
    @Published var score = 0
    @Published var isGameOver = false
    @Published var maxBubbles = GameSetting.shared.maxBubbles
    @Published var timeLeft = GameSetting.shared.timeLimit
    @Published var comboPopups: [ComboPopup] = []
    
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
        timeLeft = GameSetting.shared.timeLimit
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
        DispatchQueue.main.asyncAfter(deadline: .now() +
                                      Double(sequence.count)) {
            self.showCountdown = false
            self.startGame(for: name)
        }
    }
    
    func startGame(for name: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) {
                _ in self.tick()
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
        // Keep only the bubbles that are currently popping (flying out)
        bubbles = bubbles.filter { $0.isPopping }
        
        // Then append the new fresh bubbles
        let newBubbles = Bubble.generateBubbles(maxBubbles: maxBubbles)
        bubbles.append(contentsOf: newBubbles)
    }
    
    func pop(_ bubble: Bubble) {
        guard let index = bubbles.firstIndex(where: { $0.id == bubble.id }) else { return }
        
        // Immediately update score and combo
        let poppedBubble = bubbles[index]
        let result = ScoringEngine.evaluateCombo(
            poppedColor: poppedBubble.color,
            lastColor: lastPoppedColor,
            currentCombo: comboCount
        )
        comboCount = result.newComboCount
        score += result.awardedPoints
        lastPoppedColor = poppedBubble.color
        
        if result.isCombo {
            let popup = ComboPopup(
                text: "Combo x\(comboCount + 1)!",
                x: poppedBubble.x,
                y: poppedBubble.y
            )
            comboPopups.append(popup)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.comboPopups.removeAll { $0.id == popup.id }
            }
        }
        
        // Instead of removing immediately, mark it as popping
        bubbles[index].isPopping = true
        
        // Remove after animation delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.bubbles.removeAll { $0.id == poppedBubble.id }
        }
    }
    
    func saveHighScore() {
        HighScoreManager.save(score: score, for: playerName)
    }
}
