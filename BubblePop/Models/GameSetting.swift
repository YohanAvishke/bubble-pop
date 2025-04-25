import Foundation

extension Int {
    func nonZeroDefault(_ defaultVal: Int) -> Int {
        return self == 0 ? defaultVal : self
    }
}

/// Game settings are saved in UserDefaults
struct GameSetting {
    // Single settings object shared across the game.
    // Todo make singleton
    static var shared = GameSetting()
    
    private let timeLimitKey = "GameTimeLimit"
    private let maxBubblesKey = "MaxBubbles"
    
    var timeLimit: Int {
        get {
            UserDefaults.standard.integer(forKey: timeLimitKey)
                .nonZeroDefault(60)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: timeLimitKey)
        }
    }
    
    var maxBubbles: Int {
        get {
            UserDefaults.standard.integer(forKey: maxBubblesKey)
                .nonZeroDefault(15)
        }
        set { UserDefaults.standard.set(newValue, forKey: maxBubblesKey) }
    }
}
