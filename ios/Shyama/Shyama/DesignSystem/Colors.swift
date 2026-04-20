import SwiftUI

extension Color {
    // MARK: - Shyama Monochrome Palette
    static let canvas      = Color(hex: "FAFAFA")  // cool off-white app background
    static let surface     = Color(hex: "FFFFFF")  // pure white elevated cards — rare
    static let mist        = Color(hex: "F2F2F4")  // subtle dividers, hairlines
    static let ink         = Color(hex: "0A0A0B")  // near-black primary text
    static let inkSoft     = Color(hex: "5E5E63")  // secondary text
    static let inkMuted    = Color(hex: "A1A1A8")  // tertiary text, placeholders, hints
    static let stroke      = Color(hex: "E5E5EA")  // borders, faint

    // MARK: - Atmospheric Gradient Stops
    static let gradientStart = Color(hex: "0A0A0B")  // deep near-black — gradient top
    static let gradientMid   = Color(hex: "1E1B3E")  // deep violet-black — gradient middle
    static let gradientEnd   = Color(hex: "2B3A6B")  // muted cool blue — gradient bottom

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

// MARK: - Shared gradient

extension LinearGradient {
    /// The one Shyama atmospheric gradient. Used on Welcome background only.
    static let shyamaAtmosphere = LinearGradient(
        colors: [.gradientStart, .gradientMid, .gradientEnd],
        startPoint: .top,
        endPoint: .bottom
    )
}
