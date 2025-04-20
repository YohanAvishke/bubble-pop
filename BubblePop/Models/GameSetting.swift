import Foundation

struct GameSetting {
    static var shared = GameSetting()
    private let timerKey = "GameTimeLimit"
    private let bubblesKey = "MaxBubbles"
    var timeLimit: Int {
        get {
            UserDefaults.standard.integer(forKey: timerKey).nonZeroDefault(60)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: timerKey)
        }
    }
    var maxBubbles: Int {
        get {
            UserDefaults.standard.integer(forKey: bubblesKey).nonZeroDefault(15)
        }
        set { UserDefaults.standard.set(newValue, forKey: bubblesKey) }
    }
}

extension Int {
    func nonZeroDefault(_ defaultVal: Int) -> Int {
        return self == 0 ? defaultVal : self
    }
}
