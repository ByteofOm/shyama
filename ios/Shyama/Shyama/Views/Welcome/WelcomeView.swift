import SwiftUI

struct WelcomeView: View {
    @State private var showRootTab = false
    @State private var ringPulse: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Background atmosphere
            LinearGradient.shyamaAtmosphere
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
                        ctx.fill(dot, with: .color(.white.opacity(0.055)))
                    }
                }
            }
            .ignoresSafeArea()

            // Animated rings behind wordmark area
            GeometryReader { geo in
                let cx = geo.size.width / 2
                let cy = geo.size.height * 0.38

                Circle()
                    .stroke(Color.white.opacity(0.07), lineWidth: 0.75)
                    .frame(width: 260, height: 260)
                    .scaleEffect(ringPulse)
                    .position(x: cx, y: cy)

                Circle()
                    .stroke(Color.white.opacity(0.04), lineWidth: 0.75)
                    .frame(width: 380, height: 380)
                    .scaleEffect(ringPulse * 1.04)
                    .position(x: cx, y: cy)

                // Radial glow behind wordmark
                RadialGradient(
                    colors: [Color(hex: "2A3070").opacity(0.55), .clear],
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
                    Spacer().frame(height: geo.size.height * 0.28)

                    // Logo mark above wordmark
                    ShyamaLogoMark(color: .white, size: 32)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer().frame(height: 14)

                    GlitchWordmark()
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer().frame(height: 24)

                    Text("Skincare that sees you.")
                        .font(Font.Shyama.callout)
                        .foregroundStyle(Color.white.opacity(0.7))
                        .multilineTextAlignment(.center)

                    Spacer()

                    GlassCTAButton("Begin", variant: .secondary) {
                        showRootTab = true
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
                }
            }
        }
        .statusBarHidden(false)
        .preferredColorScheme(.dark)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(
                .easeInOut(duration: 4.0)
                .repeatForever(autoreverses: true)
            ) {
                ringPulse = 1.08
            }
        }
        .fullScreenCover(isPresented: $showRootTab) {
            RootTabView()
        }
    }
}

#Preview { WelcomeView() }
