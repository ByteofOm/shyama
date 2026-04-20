import SwiftUI

struct HomeView: View {
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default:      return "Good evening"
        }
    }

    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            VStack(spacing: Spacing.lg) {
                // Greeting
                HStack {
                    Text(greeting)
                        .font(Font.Shyama.displayMedium)
                        .foregroundStyle(Color.ink)
                    Spacer()
                }
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.lg)

                Spacer()

                // Main scan CTA
                VStack(spacing: Spacing.sm) {
                    ScanOrb { }

                    Text("Scan your skin")
                        .font(Font.Shyama.body)
                        .foregroundStyle(Color.inkSoft)
                }

                Spacer()

                // Quick-access cards
                HStack(spacing: Spacing.sm) {
                    quickCard(icon: "sparkles",              label: "Ingredients")
                    quickCard(icon: "location",              label: "Find care")
                    quickCard(icon: "clock.arrow.circlepath", label: "History")
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.lg)
            }
        }
        .navigationBarHidden(true)
    }

    private func quickCard(icon: String, label: String) -> some View {
        SoftCard {
            Button {
                print("Tapped: \(label)")
            } label: {
                VStack(spacing: Spacing.xs) {
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundStyle(Color.terracotta)
                    Text(label)
                        .font(Font.Shyama.caption)
                        .foregroundStyle(Color.inkSoft)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(label)
            .accessibilityHint("Double-tap to open \(label)")
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
