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
