import SwiftUI

extension Color {
    // MARK: - Shyama Warm Glass Palette
    static let canvas         = Color(hex: "FAF6F0")  // bone white app background
    static let surface        = Color(hex: "FFFFFF")  // elevated card surfaces — use sparingly
    static let mist           = Color(hex: "F2EADD")  // subtle dividers and secondary backgrounds
    static let ink            = Color(hex: "1F1915")  // primary text — warm near-black
    static let inkSoft        = Color(hex: "6B5F52")  // secondary text
    static let inkMuted       = Color(hex: "A39689")  // tertiary text, hints, placeholders
    static let amber          = Color(hex: "D4A574")  // primary accent — CTAs, active tab tint
    static let amberDeep      = Color(hex: "B8863D")  // pressed / emphasis variant
    static let glassHighlight = Color(white: 1.0, opacity: 0.55)
    static let glassShadow    = Color(red: 0.12, green: 0.09, blue: 0.06, opacity: 0.08)

    // MARK: - Hex initializer
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&value)
        let r, g, b, a: Double
        switch cleaned.count {
        case 6:
            r = Double((value >> 16) & 0xFF) / 255
            g = Double((value >> 8)  & 0xFF) / 255
            b = Double(value         & 0xFF) / 255
            a = 1
        case 8:
            r = Double((value >> 24) & 0xFF) / 255
            g = Double((value >> 16) & 0xFF) / 255
            b = Double((value >> 8)  & 0xFF) / 255
            a = Double(value         & 0xFF) / 255
        default:
            (r, g, b, a) = (1, 1, 1, 1)
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
