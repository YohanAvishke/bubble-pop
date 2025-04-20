import Foundation

struct ScoringResult {
    let awardedPoints: Int
    let newComboCount: Int
    let isCombo: Bool
}

struct ScoringEngine {
    static func evaluateCombo(
        poppedColor: BubbleColor,
        lastColor: BubbleColor?,
        currentCombo: Int
    ) -> ScoringResult {
        let isCombo = lastColor == poppedColor
        let comboCount = isCombo ? currentCombo + 1 : 0
        let basePoints = poppedColor.points
        let points = comboCount > 0 ? Int(round(
            Double(basePoints) * 1.5)) : basePoints
        
        return ScoringResult(
            awardedPoints: points,
            newComboCount: comboCount,
            isCombo: comboCount > 0
        )
    }
}
