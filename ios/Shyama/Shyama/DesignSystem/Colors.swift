import SwiftUI
import UIKit

extension Color {
    // MARK: - Adaptive palette (auto light/dark)
    static let canvas   = adaptive(light: "F4EBDE", dark: "14100F")  // warm ivory / deep obsidian
    static let surface  = adaptive(light: "FBF5EC", dark: "221C1A")  // elevated card / warm dark
    static let mist     = adaptive(light: "EAD9CE", dark: "1C1715")  // hairline divider tint
    static let ink      = adaptive(light: "2A1220", dark: "F2E6D4")  // deep plum / warm cream
    static let inkSoft  = adaptive(light: "5A3848", dark: "D8C4AA")  // secondary text
    static let inkMuted = adaptive(light: "8A6F7D", dark: "8A7A68")  // tertiary / placeholder
    static let stroke   = adaptive(light: "E8D4B8", dark: "3A302A")  // borders

    // MARK: - Brand accents (shift slightly between modes)
    static let accent   = adaptive(light: "C9643F", dark: "E8A54B")  // terracotta / amber
    static let primary  = adaptive(light: "3C1A2E", dark: "C7A984")  // deep plum / shea

    // MARK: - Semantic
    static let good     = adaptive(light: "5A7A4F", dark: "8FB57A")  // grade A/B
    static let warn     = adaptive(light: "C9643F", dark: "E8A54B")  // grade C
    static let bad      = adaptive(light: "A03A2B", dark: "D96B4F")  // grade D/F

    // MARK: - Fixed (always dark — used only on dark-forced surfaces)
    static let gradientStart = Color(hex: "14100F")
    static let gradientMid   = Color(hex: "1C1715")
    static let gradientEnd   = Color(hex: "221C1A")

    // MARK: - Adaptive factory

    private static func adaptive(light: String, dark: String) -> Color {
        func uiColor(_ hex: String) -> UIColor {
            let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var v: UInt64 = 0
            Scanner(string: h).scanHexInt64(&v)
            return UIColor(
                red:   CGFloat((v >> 16) & 0xFF) / 255,
                green: CGFloat((v >> 8)  & 0xFF) / 255,
                blue:  CGFloat(v         & 0xFF) / 255,
                alpha: 1
            )
        }
        return Color(UIColor { tc in
            tc.userInterfaceStyle == .dark ? uiColor(dark) : uiColor(light)
        })
    }

    // MARK: - Hex initializer (for explicit fixed colors and ad-hoc usage)
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
    // Always dark — WelcomeView background
    static let shyamaAtmosphere = LinearGradient(
        colors: [.gradientStart, .gradientMid, .gradientEnd],
        startPoint: .top, endPoint: .bottom
    )
    // Brand amber/shea gradient
    static let amberGlow = LinearGradient(
        colors: [Color(hex: "E8A54B"), Color(hex: "C7A984")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}
