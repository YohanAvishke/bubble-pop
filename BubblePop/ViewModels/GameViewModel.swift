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
        // all bubbles are spawned in pre-defined cells to stop overlapping
        bubbles = Bubble.generateBubbles(max: maxBubbles)
    }
    
    func pop(_ bubble: Bubble) {
        // verify and remove the popped bubble
        guard let index = bubbles
            .firstIndex(where: { $0.id == bubble.id }) else { return }
        bubbles.remove(at: index)
        
        // scoring and combo calculations
        let result = ScoringEngine.evaluateCombo(
            poppedColor: bubble.color,
            lastColor: lastPoppedColor,
            currentCombo: comboCount
        )
        comboCount = result.newComboCount
        score += result.awardedPoints
        lastPoppedColor = bubble.color
        if result.isCombo {
            let popup = ComboPopup(
                text: "Combo x\(comboCount + 1)!",
                x: bubble.x,
                y: bubble.y
            )
            comboPopups.append(popup)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.comboPopups.removeAll { $0.id == popup.id }
            }
        }
    }
    
    func saveHighScore() {
        HighScoreManager.save(score: score, for: playerName)
    }
}
