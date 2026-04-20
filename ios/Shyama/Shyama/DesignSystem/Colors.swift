import SwiftUI

extension Color {
    // MARK: - Shyama Obsidian Palette (dark-first, warm)
    static let canvas      = Color(hex: "14100F")   // deep obsidian background
    static let surface     = Color(hex: "221C1A")   // elevated surfaces
    static let mist        = Color(hex: "1C1715")   // subtle secondary bg
    static let ink         = Color(hex: "F2E6D4")   // warm cream — primary text
    static let inkSoft     = Color(hex: "D8C4AA")   // secondary text
    static let inkMuted    = Color(hex: "8A7A68")   // tertiary / placeholder
    static let stroke      = Color(hex: "3A302A")   // borders, hairlines

    // MARK: - Brand Accents
    static let accent      = Color(hex: "E8A54B")   // warm amber — primary CTA
    static let primary     = Color(hex: "C7A984")   // shea — secondary accent

    // MARK: - Semantic
    static let good        = Color(hex: "8FB57A")   // grade A/B
    static let warn        = Color(hex: "E8A54B")   // grade C / caution
    static let bad         = Color(hex: "D96B4F")   // grade D/F / alert

    // MARK: - Atmospheric Gradient Stops
    static let gradientStart = Color(hex: "14100F")  // obsidian
    static let gradientMid   = Color(hex: "1C1715")  // warm dark
    static let gradientEnd   = Color(hex: "221C1A")  // warm surface

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

// MARK: - Shared gradients

extension LinearGradient {
    static let shyamaAtmosphere = LinearGradient(
        colors: [.gradientStart, .gradientMid, .gradientEnd],
        startPoint: .top,
        endPoint: .bottom
    )

    static let amberGlow = LinearGradient(
        colors: [Color(hex: "E8A54B"), Color(hex: "C7A984")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
