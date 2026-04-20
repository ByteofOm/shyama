import SwiftUI

struct WelcomeView: View {
    @State private var showRootTab = false

    var body: some View {
        ZStack {
            LinearGradient.shyamaAtmosphere
                .ignoresSafeArea()

            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer().frame(height: geo.size.height * 0.38)

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
        .fullScreenCover(isPresented: $showRootTab) {
            RootTabView()
        }
    }
}

#Preview { WelcomeView() }
