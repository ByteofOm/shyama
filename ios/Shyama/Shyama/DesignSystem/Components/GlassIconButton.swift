import SwiftUI

/// Circular 44×44pt glass icon button for secondary actions (close, back, camera flip).
struct GlassIconButton: View {
    let icon: String
    let action: () -> Void
    var accessibilityLabel: String = ""

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(Color.ink)
                .frame(width: 44, height: 44)
        }
        .glassEffect(.regular.interactive(), in: .circle)
        .accessibilityLabel(accessibilityLabel.isEmpty ? icon : accessibilityLabel)
        .accessibilityHint("Double-tap to activate")
    }
}

#Preview {
    HStack(spacing: 16) {
        GlassIconButton(icon: "xmark", accessibilityLabel: "Close") {}
        GlassIconButton(icon: "arrow.left", accessibilityLabel: "Back") {}
        GlassIconButton(icon: "camera.rotate", accessibilityLabel: "Flip camera") {}
    }
    .padding()
    .background(Color.canvas)
}
