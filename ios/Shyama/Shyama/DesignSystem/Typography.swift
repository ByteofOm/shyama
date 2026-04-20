import SwiftUI
import CoreText

// Call once at app launch — registers bundled TTF files so Font.custom resolves correctly.
func registerFonts() {
    let filenames = [
        "InterTight-VariableFont_wght",
        "Mukta-Regular",
        "Mukta-SemiBold"
    ]
    for name in filenames {
        guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else {
            print("ℹ️ Font not bundled: \(name).ttf")
            continue
        }
        var error: Unmanaged<CFError>?
        let ok = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
        if !ok {
            print("ℹ️ Font \(name): already registered or failed")
        }
    }
}

// Semantic type scale. Use as Font.Shyama.displayXL etc.
extension Font {
    enum Shyama {
        /// Inter Tight 56pt — hero display (Welcome wordmark)
        static let displayXL: Font = .custom("InterTight-Regular", size: 56, relativeTo: .largeTitle)
        /// Inter Tight 40pt — major screen headlines
        static let displayLarge: Font = .custom("InterTight-Regular", size: 40, relativeTo: .largeTitle)
        /// Inter Tight 28pt — section headlines
        static let displayMedium: Font = .custom("InterTight-Regular", size: 28, relativeTo: .title)

        /// SF Pro — UI text with proper Dynamic Type support.
        static let headline: Font = .system(.headline, design: .default, weight: .semibold)
        static let body: Font = .system(.body, design: .default, weight: .regular)
        static let callout: Font = .system(.callout, design: .default, weight: .regular)
        static let caption: Font = .system(.caption, design: .default, weight: .regular)
        static let footnote: Font = .system(.footnote, design: .default, weight: .regular)

        /// Mukta SemiBold 56pt — for "श्यामा" in GlitchWordmark only.
        static let devanagariDisplay: Font = .custom("Mukta-SemiBold", size: 56, relativeTo: .largeTitle)
    }
}
