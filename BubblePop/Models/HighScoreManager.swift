import Foundation

/// High scores are saved in UserDefaults
struct HighScoreManager {
    private static let highScoreskey = "HighScores"
    
    private static var scores = UserDefaults.standard
        .stringArray(forKey: highScoreskey) ?? []
    
    static func save(score: Int, for player: String) {
        let entry = "\(player): \(score)"
        scores.append(entry)
        UserDefaults.standard.set(scores, forKey: highScoreskey)
    }
    
    static func fetchAllSortedbyHighest() -> [String] {
        /*
         Since HighScores keep both player name and score as a string. String
         needs to be trimmed and then sorted
         */
        return scores.sorted {
            (
                Int($0.split(separator: ":").last?
                    .trimmingCharacters(in: .whitespaces) ?? "") ?? 0
            ) >
            (
                Int($1.split(separator: ":").last?
                    .trimmingCharacters(in: .whitespaces) ?? "") ?? 0
            )
        }
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
