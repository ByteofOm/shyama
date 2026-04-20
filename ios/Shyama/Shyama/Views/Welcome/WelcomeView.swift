import SwiftUI

struct WelcomeView: View {
    @State private var showRootTab = false

    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            GeometryReader { geo in
                VStack(spacing: 0) {
                    // Position wordmark ~35% from top of screen
                    Spacer().frame(height: geo.size.height * 0.30)

                    GlitchWordmark()
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer().frame(height: 32)

                    Text("Skincare that sees you.")
                        .font(.custom("DMSans-9ptRegular", size: 15))
                        .foregroundStyle(Color.inkSoft)
                        .multilineTextAlignment(.center)

                    Spacer().frame(height: 64)

                    GlassCTAButton("Begin") {
                        showRootTab = true
                    }
                    .padding(.horizontal, 32)

                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .statusBarHidden(false)
        .fullScreenCover(isPresented: $showRootTab) {
            RootTabView()
        }
    }
}

#Preview {
    WelcomeView()
}
