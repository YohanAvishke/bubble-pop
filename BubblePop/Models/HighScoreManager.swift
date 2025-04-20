import Foundation

struct HighScoreManager {
    private static let key = "HighScores"
    private static var scores = UserDefaults.standard
        .stringArray(forKey: key) ?? []
    
    static func save(score: Int, for player: String) {
        let entry = "\(player): \(score)"
        scores.append(entry)
        UserDefaults.standard.set(scores, forKey: key)
    }
    
    static func fetchAllSortedbyHighest() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key)?
            .sorted(by: { $0 > $1 }) ?? []
    }
    
    static func fetchHighestScore() -> Int {
        return scores
            .compactMap {
                $0.split(separator: ":")
                    .last?
                    .trimmingCharacters(in: .whitespaces)
            }
            .compactMap(Int.init)
            .max() ?? 0
    }
}
