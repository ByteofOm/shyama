import SwiftUI

struct SoftButton: View {
    enum Variant { case standard, prominent }

    let title: String
    let variant: Variant
    let action: () -> Void

    init(_ title: String, variant: Variant = .standard, action: @escaping () -> Void) {
        self.title = title
        self.variant = variant
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(SoftButtonStyle(variant: variant))
        .accessibilityLabel(title)
        .accessibilityHint("Double-tap to activate")
    }
}

// MARK: - ButtonStyle

struct SoftButtonStyle: ButtonStyle {
    let variant: SoftButton.Variant

    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        let bg: Color = variant == .prominent ? .terracotta : .canvas
        let fg: Color = variant == .prominent ? .white : .ink

        configuration.label
            .font(.custom("DMSans-Medium", size: 16))
            .foregroundStyle(fg)
            .padding(.horizontal, Spacing.xl)
            .padding(.vertical, Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(bg)
            )
            // Border satisfies WCAG non-color-alone indicator rule
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(fg.opacity(0.10), lineWidth: 1)
            )
            // Soft-UI dual shadow: light top-left, dark bottom-right (inverted on press)
            .shadow(
                color: .white.opacity(0.6),
                radius: 4,
                x: pressed ? 4 : -4,
                y: pressed ? 4 : -4
            )
            .shadow(
                color: Color.ink.opacity(0.12),
                radius: 6,
                x: pressed ? -6 : 6,
                y: pressed ? -6 : 6
            )
            .scaleEffect(pressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.15, dampingFraction: 0.7), value: pressed)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 24) {
        SoftButton("Standard") { }
        SoftButton("Begin", variant: .prominent) { }
    }
    .padding()
    .background(Color.canvas)
}
