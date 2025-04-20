import Foundation

struct HighScoreManager {
    private static let key = "HighScores"
    
    static func save(score: Int, for player: String) {
        let entry = "\(player): \(score)"
        var scores = UserDefaults.standard.stringArray(forKey: key) ?? []
        scores.append(entry)
        UserDefaults.standard.set(scores, forKey: key)
    }
    
    static func fetchSorted() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key)?
            .sorted(by: { $0 < $1 }) ?? []
    }
}

