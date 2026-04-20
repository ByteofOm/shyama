import SwiftUI
import CoreText

// Call once at app launch — registers bundled TTF files so Font.custom resolves correctly.
func registerFonts() {
    let filenames = [
        "Fraunces-VariableFont_SOFT,WONK,opsz,wght",
        "DMSans-VariableFont_opsz,wght",
        "Mukta-Regular",
        "Mukta-SemiBold"
    ]
    for name in filenames {
        guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else {
            print("⚠️ Font file not found in bundle: \(name).ttf")
            continue
        }
        var error: Unmanaged<CFError>?
        let ok = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
        if !ok {
            // Already registered on subsequent launches — not a real error
            let code = error?.takeRetainedValue().localizedDescription ?? "unknown"
            print("ℹ️ Font \(name): \(code)")
        }
    }
}

// Semantic type scale. Use as Font.Shyama.displayLarge etc.
// Nested under Font.Shyama to avoid shadowing SwiftUI's built-in Font.body / .headline / .caption.
extension Font {
    enum Shyama {
        /// Fraunces 40pt — use .fontWeight(.medium) at call site for weight 500
        static let displayLarge: Font     = .custom("Fraunces-9ptBlack",     size: 40, relativeTo: .largeTitle)
        /// Fraunces 28pt
        static let displayMedium: Font    = .custom("Fraunces-9ptBlack",     size: 28, relativeTo: .title)
        /// DM Sans 20pt — use .fontWeight(.semibold) at call site
        static let headline: Font         = .custom("DMSans-9ptRegular",     size: 20, relativeTo: .headline)
        /// DM Sans 16pt
        static let body: Font             = .custom("DMSans-9ptRegular",     size: 16, relativeTo: .body)
        /// DM Sans 13pt
        static let caption: Font          = .custom("DMSans-9ptRegular",     size: 13, relativeTo: .caption)
        /// Mukta 24pt — Devanagari wordmark "श्यामा" and accent phrases
        static let devanagariAccent: Font = .custom("Mukta-SemiBold",        size: 24, relativeTo: .title2)
    }
}
