import SwiftUI

struct ScanOrb: View {
    let action: () -> Void

    @State private var pulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.terracotta)
                    .frame(width: 180, height: 180)
                    // Outer soft shadow
                    .shadow(color: .white.opacity(0.5), radius: 8, x: -4, y: -4)
                    .shadow(color: Color.ink.opacity(0.18), radius: 12, x: 6, y: 8)

                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 48, weight: .regular))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        // Breathing scale animation — disabled when reduce motion is on
        .scaleEffect(pulsing ? 1.03 : 1.0)
        .animation(
            reduceMotion ? nil : .easeInOut(duration: 2.5).repeatForever(autoreverses: true),
            value: pulsing
        )
        .onAppear {
            guard !reduceMotion else { return }
            pulsing = true
        }
        .accessibilityLabel("Scan your skin")
        .accessibilityHint("Double-tap to open the camera and scan a skin condition")
    }
}

// MARK: - Preview

#Preview {
    ScanOrb { }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.canvas)
}
