import Foundation

struct ScoringResult {
    let awardedPoints: Int
    let newComboCount: Int
    let isCombo: Bool
}

struct ScoringEngine {
    
    /// Calculate combos
    /// - Parameters:
    ///   - poppedColor: what colour is popped
    ///   - lastColor: reference to colour before (for combos)
    ///   - currentComboCount: players current combo status
    /// - Returns: ScoringResult
    static func evaluateCombo(poppedColor: BubbleColor,
                              lastColor: BubbleColor?,
                              currentComboCount: Int) -> ScoringResult {
        let isCombo = lastColor == poppedColor
        // if it's not a new combo, reset existing
        let comboCount = isCombo ? currentComboCount + 1 : 0
        let basePoints = poppedColor.points
        // keeping an combo multiply points by 1.5x
        let points = comboCount > 0 ? Int(
            round(Double(basePoints) * 1.5)) : basePoints
        
        return ScoringResult(
            awardedPoints: points,
            newComboCount: comboCount,
            isCombo: comboCount > 0
        )
    }
}
