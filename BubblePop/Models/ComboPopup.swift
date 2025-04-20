import Foundation

struct ComboPopup: Identifiable {
    let id = UUID()
    let text: String
    let x: CGFloat  // Normalized (0.0 - 1.0)
    let y: CGFloat  // Normalized
}
