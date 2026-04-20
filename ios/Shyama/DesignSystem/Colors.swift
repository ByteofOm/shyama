import SwiftUI

extension Color {
    // MARK: - Shyama Palette
    static let canvas      = Color(hex: "F2ECE0")  // warm cream background
    static let canvasDeep  = Color(hex: "E8DFCE")  // recessed surfaces, inset shadow targets
    static let ink         = Color(hex: "1A1410")  // primary text, near-black with warmth
    static let inkSoft     = Color(hex: "5C4A3E")  // secondary text
    static let terracotta  = Color(hex: "B8502E")  // primary accent — CTA, scan button
    static let honey       = Color(hex: "D9A441")  // secondary accent — highlights, confidence bars
    static let forest      = Color(hex: "2E5D4F")  // success, "skin-friendly" indicators
    static let clay        = Color(hex: "8B4513")  // tertiary, ingredient warnings

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
