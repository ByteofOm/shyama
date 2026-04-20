import SwiftUI

struct WelcomeView: View {
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.canvas.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    // Wordmark lockup
                    Text("Shyama")
                        .font(.custom("Fraunces-Medium", size: 56))
                        .foregroundStyle(Color.ink)

                    Text("श्यामा")
                        .font(.custom("MuktaDevanagari-Regular", size: 32))
                        .foregroundStyle(Color.inkSoft)
                        .padding(.top, Spacing.xs)

                    Text("Skincare that sees you.")
                        .font(.custom("DMSans-Regular", size: 15))
                        .foregroundStyle(Color.inkSoft)
                        .padding(.top, Spacing.sm)

                    Spacer()

                    SoftButton("Begin", variant: .prominent) {
                        goToHome = true
                    }
                    .padding(.bottom, Spacing.xxl)
                }
                .padding(.horizontal, Spacing.xl)
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $goToHome) {
                HomeView()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    WelcomeView()
}
