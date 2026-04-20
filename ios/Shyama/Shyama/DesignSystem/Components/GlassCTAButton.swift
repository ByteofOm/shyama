import SwiftUI

/// Primary/secondary CTA button. Two variants:
/// - `.primary`: solid ink fill, white label — for light (canvas) backgrounds.
/// - `.secondary`: glass capsule, ink label — for dark (gradient) backgrounds.
struct GlassCTAButton: View {
    enum Variant { case primary, secondary }

    private let title: String
    private let icon: String?
    private let variant: Variant
    private let action: () -> Void

    init(_ title: String, icon: String? = nil, variant: Variant = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.variant = variant
        self.action = action
    }

    var body: some View {
        switch variant {
        case .primary:  primaryButton
        case .secondary: secondaryButton
        }
    }

    private var label: some View {
        HStack(spacing: 8) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
            }
            Text(title)
                .font(Font.Shyama.callout.weight(.semibold))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .padding(.horizontal, 24)
    }

    private var primaryButton: some View {
        Button(action: action) {
            label
                .foregroundStyle(Color.white)
                .background(Color.ink, in: .capsule)
        }
        .buttonStyle(PressScaleStyle())
        .accessibilityLabel(title)
        .accessibilityHint("Double-tap to activate")
    }

    private var secondaryButton: some View {
        Button(action: action) {
            label
                .foregroundStyle(Color.ink)
        }
        .glassEffect(.regular, in: .capsule)
        .accessibilityLabel(title)
        .accessibilityHint("Double-tap to activate")
    }
}

// Subtle scale-down on press for the primary solid button.
private struct PressScaleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 20) {
        GlassCTAButton("Open camera", icon: "camera", variant: .primary) {}
            .padding(.horizontal, 32)
        GlassCTAButton("Begin", variant: .secondary) {}
            .padding(.horizontal, 32)
    }
    .padding(.vertical, 40)
    .background(Color.canvas)
}
