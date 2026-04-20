import SwiftUI
import CoreText

// Call once at app launch — registers bundled TTF files so Font.custom resolves correctly.
func registerFonts() {
    let names = [
        "Fraunces-Regular", "Fraunces-Medium", "Fraunces-SemiBold",
        "DMSans-Regular", "DMSans-Medium", "DMSans-SemiBold",
        "MuktaDevanagari-Regular", "MuktaDevanagari-SemiBold"
    ]
    for name in names {
        guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else { continue }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
    }
}

// Semantic type scale. Use as Font.Shyama.displayLarge etc.
// Nested under Font.Shyama to avoid shadowing SwiftUI's built-in Font.body / .headline / .caption.
extension Font {
    enum Shyama {
        /// Fraunces 40pt / weight 500
        static let displayLarge: Font    = .custom("Fraunces-Medium",             size: 40, relativeTo: .largeTitle)
        /// Fraunces 28pt / weight 500
        static let displayMedium: Font   = .custom("Fraunces-Medium",             size: 28, relativeTo: .title)
        /// DM Sans 20pt / weight 600
        static let headline: Font        = .custom("DMSans-SemiBold",             size: 20, relativeTo: .headline)
        /// DM Sans 16pt / weight 400
        static let body: Font            = .custom("DMSans-Regular",              size: 16, relativeTo: .body)
        /// DM Sans 13pt / weight 400
        static let caption: Font         = .custom("DMSans-Regular",              size: 13, relativeTo: .caption)
        /// Mukta 24pt / weight 600 — Devanagari wordmark "श्यामा" and accent phrases
        static let devanagariAccent: Font = .custom("MuktaDevanagari-SemiBold",  size: 24, relativeTo: .title2)
    }
}
