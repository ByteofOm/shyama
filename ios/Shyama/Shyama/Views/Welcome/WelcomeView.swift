import SwiftUI

struct WelcomeView: View {
    @State private var showRootTab = false
    @State private var ringPulse: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Background
            LinearGradient.shyamaAtmosphere
                .ignoresSafeArea()

            // Warm ambient glow from bottom
            RadialGradient(
                colors: [Color(hex: "C9643F").opacity(0.18), .clear],
                center: .bottom,
                startRadius: 0,
                endRadius: 500
            )
            .ignoresSafeArea()

            // Dot grid texture
            Canvas { ctx, sz in
                let spacing: CGFloat = 32
                let cols = Int(sz.width / spacing) + 1
                let rows = Int(sz.height / spacing) + 1
                for row in 0...rows {
                    for col in 0...cols {
                        let x = CGFloat(col) * spacing
                        let y = CGFloat(row) * spacing
                        let dot = Path(ellipseIn: CGRect(x: x - 0.5, y: y - 0.5, width: 1, height: 1))
                        ctx.fill(dot, with: .color(.white.opacity(0.05)))
                    }
                }
            }
            .ignoresSafeArea()

            GeometryReader { geo in
                let cx = geo.size.width / 2
                let cy = geo.size.height * 0.36

                // Pulsing rings
                Circle()
                    .stroke(Color.accent.opacity(0.08), lineWidth: 1)
                    .frame(width: 280, height: 280)
                    .scaleEffect(ringPulse)
                    .position(x: cx, y: cy)

                Circle()
                    .stroke(Color.accent.opacity(0.04), lineWidth: 1)
                    .frame(width: 420, height: 420)
                    .scaleEffect(ringPulse * 1.04)
                    .position(x: cx, y: cy)

                // Amber radial glow
                RadialGradient(
                    colors: [Color(hex: "E8A54B").opacity(0.2), .clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 160
                )
                .frame(width: 320, height: 320)
                .position(x: cx, y: cy)
            }
            .ignoresSafeArea()

            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer().frame(height: geo.size.height * 0.26)

                    // Triple moon logo mark
                    ShyamaLogoMark(color: Color.accent, size: 48)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer().frame(height: 20)

                    // Wordmark
                    GlitchWordmark()
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer().frame(height: 20)

                    Text("Skincare that sees you.")
                        .font(Font.Shyama.callout)
                        .foregroundStyle(Color.inkSoft)
                        .multilineTextAlignment(.center)

                    Spacer()

                    GlassCTAButton("Begin your ritual", variant: .secondary) {
                        showRootTab = true
                    }
                    .padding(.horizontal, 32)

                    Text("Already here? Sign in")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.inkMuted)
                        .padding(.top, 12)

                    Spacer().frame(height: 48)
                }
            }
        }
        .statusBarHidden(false)
        .preferredColorScheme(.dark)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
                ringPulse = 1.08
            }
        }
        .fullScreenCover(isPresented: $showRootTab) {
            RootTabView()
        }
    }
}

#Preview { WelcomeView() }
