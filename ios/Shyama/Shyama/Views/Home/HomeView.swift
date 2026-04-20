import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            // Radial glow behind content
            RadialGradient(
                colors: [Color.accent.opacity(0.12), .clear],
                center: .top,
                startRadius: 0,
                endRadius: 340
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    skinCard
                    ritualSection
                    nearbySection
                    Spacer().frame(height: 32)
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("SHYAMA")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(3)
                    .foregroundStyle(Color.inkMuted)
                Text("Good morning.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(Color.ink)
            }
            Spacer()
            ShyamaLogoMark(color: Color.accent, size: 34)
        }
        .padding(.top, 16)
        .padding(.bottom, 28)
    }

    // MARK: - Skin score card

    private var skinCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.surface)

            // Subtle pattern overlay
            Canvas { ctx, sz in
                for row in stride(from: 0, to: sz.height, by: 36) {
                    for col in stride(from: 0, to: sz.width, by: 36) {
                        let dot = Path(ellipseIn: CGRect(x: col + (row.truncatingRemainder(dividingBy: 72) == 0 ? 18 : 0), y: row, width: 1.5, height: 1.5))
                        ctx.fill(dot, with: .color(Color.ink.opacity(0.06)))
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("SKIN TODAY")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(2)
                        .foregroundStyle(Color.inkMuted)
                    Spacer()
                    Text("+ 3 pts")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.accent)
                }

                HStack(alignment: .center, spacing: 16) {
                    gradeText("B+", size: 72, color: .good)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hydration up, barrier strong")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.ink)
                        Text("Based on last scan · 2d ago")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.inkMuted)
                    }
                }
                .padding(.top, 12)

                // Progress bars
                HStack(spacing: 6) {
                    ForEach([1.0, 0.85, 0.7, 0.3], id: \.self) { v in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(v > 0.5 ? Color.good : Color.stroke)
                            .frame(height: 5)
                            .opacity(v > 0.5 ? v : 0.3)
                    }
                }
                .padding(.top, 16)
            }
            .padding(20)
        }
    }

    // MARK: - Ritual section

    private var ritualSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TODAY'S RITUAL")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 28)

            VStack(spacing: 10) {
                ritualRow(icon: "sun.max", title: "SPF check-in", subtitle: "Mineral, reef-safe, no cast", badge: "A", done: false)
                ritualRow(icon: "drop", title: "Hydration scan", subtitle: "Camera · 3 min", badge: nil, done: true)
                ritualRow(icon: "sparkles", title: "Product review", subtitle: "Faded serum · day 14", badge: "A−", done: false)
            }
        }
    }

    private func ritualRow(icon: String, title: String, subtitle: String, badge: String?, done: Bool) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.surface)
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(done ? Color.inkMuted : Color.accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(done ? Color.inkMuted : Color.ink)
                    .strikethrough(done)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()

            if let badge {
                Text(badge)
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .foregroundStyle(Color.good)
            }
        }
        .padding(14)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
        .opacity(done ? 0.6 : 1)
    }

    // MARK: - Nearby section

    private var nearbySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("NEAR YOU")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.inkMuted)
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.accent)
            }
            .padding(.top, 28)

            VStack(spacing: 10) {
                nearbyRow(name: "Mahogany Hair Studio", tags: "4c specialist · locs", grade: "A", dist: "0.8 mi", verified: true)
                nearbyRow(name: "Shea Skin Bar", tags: "Dermaplaning · facials", grade: "B+", dist: "1.4 mi", verified: true)
            }
        }
    }

    private func nearbyRow(name: String, tags: String, grade: String, dist: String, verified: Bool) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient.amberGlow.opacity(0.3))
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 4) {
                    Text(name)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.ink)
                    if verified {
                        Text("✓")
                            .font(.system(size: 9))
                            .foregroundStyle(Color.accent)
                    }
                }
                Text(tags)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkMuted)
                Text(dist)
                    .font(.system(size: 10))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()

            Text(grade)
                .font(.system(size: 22, weight: .bold, design: .serif))
                .foregroundStyle(Color.good)
        }
        .padding(14)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Helpers

    private func gradeText(_ text: String, size: CGFloat, color: Color) -> some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .serif))
            .italic()
            .foregroundStyle(color)
    }
}

#Preview {
    HomeView()
}
