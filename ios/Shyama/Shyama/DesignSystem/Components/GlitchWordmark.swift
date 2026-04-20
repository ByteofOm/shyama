import SwiftUI

/// Signature animation component: morphs between "Shyama" (Fraunces 40pt) and
/// "श्यामा" (Mukta 40pt) with a character-by-character scramble at ~30Hz per character.
struct GlitchWordmark: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var startTime: Date = .now
    @State private var showingEnglish = true

    private let englishChars: [String] = ["S", "h", "y", "a", "m", "a"]

    // Swift grapheme clusters of "श्यामा", zero-padded to 6 to match English width
    private let devanagariChars: [String] = {
        let raw = Array("श्यामा").map(String.init)
        let pad = Array(repeating: " ", count: max(0, 6 - raw.count))
        return raw + pad
    }()

    private let devanagariPool = [
        "क", "ख", "ग", "घ", "च", "ज", "ट", "त", "द", "न",
        "प", "ब", "म", "य", "र", "ल", "व", "श", "ह", "ड"
    ]
    private let latinPool = [
        "A","B","C","D","E","F","G","H","I","J",
        "K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
    ]

    private let holdDuration: Double = 2.5
    private let scrambleDuration: Double = 0.4

    // Font.Shyama.devanagariAccent scaled up to 40pt for wordmark display
    private var devanagariLarge: Font {
        .custom("Mukta-SemiBold", size: 40, relativeTo: .largeTitle)
    }

    var body: some View {
        Group {
            if reduceMotion {
                reducedBody
            } else {
                TimelineView(.animation) { ctx in
                    let fullCycle = (holdDuration + scrambleDuration) * 2
                    let t = ctx.date.timeIntervalSince(startTime)
                                   .truncatingRemainder(dividingBy: fullCycle)
                    animatedBody(t: t, date: ctx.date)
                }
                .onAppear { startTime = .now }
            }
        }
        .accessibilityLabel("Shyama — an inclusive skincare companion")
        .accessibilityElement(children: .ignore)
    }

    // MARK: - Reduced motion

    private var reducedBody: some View {
        Text(showingEnglish ? "Shyama" : "श्यामा")
            .font(showingEnglish ? Font.Shyama.displayLarge : devanagariLarge)
            .foregroundStyle(Color.ink)
            .animation(.easeInOut(duration: 0.5), value: showingEnglish)
            .task {
                while !Task.isCancelled {
                    try? await Task.sleep(for: .seconds(3.5))
                    withAnimation { showingEnglish.toggle() }
                }
            }
    }

    // MARK: - Animated body

    @ViewBuilder
    private func animatedBody(t: Double, date: Date) -> some View {
        if t < holdDuration {
            wordRow(chars: englishChars, font: Font.Shyama.displayLarge)
        } else if t < holdDuration + scrambleDuration {
            scrambleRow(
                from: englishChars, to: devanagariChars,
                fromFont: Font.Shyama.displayLarge, toFont: devanagariLarge,
                pool: devanagariPool,
                progress: (t - holdDuration) / scrambleDuration,
                date: date
            )
        } else if t < 2 * holdDuration + scrambleDuration {
            wordRow(chars: devanagariChars, font: devanagariLarge)
        } else {
            scrambleRow(
                from: devanagariChars, to: englishChars,
                fromFont: devanagariLarge, toFont: Font.Shyama.displayLarge,
                pool: latinPool,
                progress: (t - (2 * holdDuration + scrambleDuration)) / scrambleDuration,
                date: date
            )
        }
    }

    // MARK: - Row renderers

    private func wordRow(chars: [String], font: Font) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(chars.enumerated()), id: \.offset) { _, char in
                Text(char)
                    .font(font)
                    .foregroundStyle(Color.ink)
            }
        }
    }

    private func scrambleRow(
        from: [String], to: [String],
        fromFont: Font, toFont: Font,
        pool: [String], progress: Double, date: Date
    ) -> some View {
        let n = max(from.count, to.count)
        return HStack(spacing: 0) {
            ForEach(Array(0..<n), id: \.self) { i in
                charView(
                    i: i, n: n, from: from, to: to,
                    fromFont: fromFont, toFont: toFont,
                    pool: pool, progress: progress, date: date
                )
            }
        }
    }

    // Resolves a single character's display state outside a @ViewBuilder context.
    private func charView(
        i: Int, n: Int,
        from: [String], to: [String],
        fromFont: Font, toFont: Font,
        pool: [String], progress: Double, date: Date
    ) -> some View {
        let stagger = n > 1 ? Double(i) / Double(n - 1) : 0.0
        let resolved = progress >= stagger
        let text: String
        let font: Font
        let opacity: Double
        let jitter: CGFloat

        if resolved {
            text    = i < to.count ? to[i] : " "
            font    = toFont
            opacity = 1.0
            jitter  = 0
        } else {
            let tick = Int(date.timeIntervalSinceReferenceDate * 30) + i * 37
            let idx  = ((tick % pool.count) + pool.count) % pool.count
            text    = pool[idx]
            font    = fromFont
            opacity = 0.6
            jitter  = CGFloat(sin(date.timeIntervalSinceReferenceDate * 23 + Double(i) * 3.7))
        }

        return Text(text)
            .font(font)
            .foregroundStyle(Color.ink)
            .opacity(opacity)
            .offset(x: jitter)
    }
}

#Preview {
    GlitchWordmark()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.canvas)
}
