import SwiftUI

/// Primary glass CTA button (Begin, Capture, Analyze). Amber-tinted, capsule shape, 54pt height.
/// Apply to full-width contexts; pass `icon` for a leading SF Symbol.
struct GlassCTAButton: View {
    private let title: String
    private let icon: String?
    private let action: () -> Void

    init(_ title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                }
                Text(title)
                    .font(.custom("DMSans-9ptRegular", size: 17).weight(.medium))
            }
            .foregroundStyle(Color.ink)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(.horizontal, 24)
        }
        .glassEffect(.regular.tint(Color.amber.opacity(0.85)), in: .capsule)
        .accessibilityLabel(title)
        .accessibilityHint("Double-tap to activate")
    }
}

#Preview {
    VStack(spacing: 16) {
        GlassCTAButton("Begin") {}
        GlassCTAButton("Open camera", icon: "camera") {}
    }
    .padding()
    .background(Color.canvas)
}
