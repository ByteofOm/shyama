import SwiftUI

struct ScanView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header
                    consentCard
                    tipsSection
                    Spacer().frame(height: 40)
                    GlassCTAButton("I'm ready →", icon: "camera.viewfinder") {
                        print("Open camera")
                    }
                    Spacer().frame(height: 32)
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("PRIVATE SCAN")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 16)
            Text("A little\nlove note.")
                .font(Font.Shyama.displayMedium)
                .foregroundStyle(Color.ink)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 24)
    }

    // MARK: - Consent card

    private var consentCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(
                        colors: [Color(hex: "3C1A2E"), Color(hex: "C9643F")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 160)

                RadialGradient(
                    colors: [Color.accent.opacity(0.35), .clear],
                    center: .topTrailing,
                    startRadius: 0,
                    endRadius: 200
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 160)

                VStack(alignment: .leading, spacing: 6) {
                    ShyamaLogoMark(color: .white.opacity(0.7), size: 24)
                    Text("Your skin is\nsafe here.")
                        .font(.system(size: 22, weight: .bold, design: .serif))
                        .italic()
                        .foregroundStyle(.white)
                }
                .padding(20)
            }

            Text("This scan is just for you. Photos never leave your phone unless you choose to share them. Our model is trained on deep skin — so concerns like hyperpigmentation, keloids, and folliculitis are seen clearly, not erased.")
                .font(Font.Shyama.body)
                .foregroundStyle(Color.inkSoft)
                .lineSpacing(3)
        }
    }

    // MARK: - Tips

    private var tipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("BEFORE YOU SCAN")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 28)

            VStack(spacing: 10) {
                tipRow("1", title: "Natural light", detail: "Near a window, not direct sun")
                tipRow("2", title: "Clean skin", detail: "Bare, no makeup or filters")
                tipRow("3", title: "Hold still", detail: "We'll take 3 angles for accuracy")
            }
        }
    }

    private func tipRow(_ number: String, title: String, detail: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.accent.opacity(0.15))
                    .frame(width: 32, height: 32)
                Text(number)
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.ink)
                Text(detail)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ScanView()
}
