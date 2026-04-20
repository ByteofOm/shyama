import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    profileHeader
                    statsRow
                    passportCard
                    savedSection
                    settingsSection
                    Spacer().frame(height: 32)
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Header

    private var profileHeader: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient.amberGlow)
                    .frame(width: 72, height: 72)
                Text("A")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.canvas)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Amina K.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(Color.ink)
                Text("4c · cocoa · sensitive")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.inkMuted)
                Text("Sis since 2024")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.accent)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.accent.opacity(0.15), in: Capsule())
                    .padding(.top, 4)
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 24)
    }

    // MARK: - Stats

    private var statsRow: some View {
        HStack(spacing: 10) {
            statCell(value: "14", label: "Streak")
            statCell(value: "23", label: "Saved")
            statCell(value: "8", label: "Ritual")
        }
    }

    private func statCell(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundStyle(Color.ink)
            Text(label.uppercased())
                .font(.system(size: 9, weight: .semibold))
                .tracking(1.5)
                .foregroundStyle(Color.inkMuted)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Skin Passport card

    private var passportCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(
                        colors: [Color(hex: "3C1A2E"), Color(hex: "E8A54B")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))

                // Pattern
                Canvas { ctx, sz in
                    for row in stride(from: 0, to: sz.height, by: 36) {
                        for col in stride(from: 0, to: sz.width, by: 36) {
                            let cx = col + (row.truncatingRemainder(dividingBy: 72) == 0 ? 18 : 0)
                            let dot = Path(ellipseIn: CGRect(x: cx, y: row, width: 1.5, height: 1.5))
                            ctx.fill(dot, with: .color(.white.opacity(0.1)))
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("SHYAMA PASSPORT")
                                .font(.system(size: 9, weight: .semibold))
                                .tracking(2)
                                .foregroundStyle(.white.opacity(0.65))
                            Text("Amina Kamau")
                                .font(.system(size: 22, weight: .bold, design: .serif))
                                .italic()
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        ShyamaLogoMark(color: .white.opacity(0.6), size: 32)
                    }

                    Divider().overlay(Color.white.opacity(0.2))

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        passportField(label: "SKIN", value: "Cocoa · sensitive")
                        passportField(label: "HAIR", value: "Type 4c · locs")
                        passportField(label: "FOCUS", value: "Hyperpigment.")
                        passportField(label: "AVOID", value: "Fragrance, SLS")
                    }
                }
                .padding(20)
            }
        }
        .padding(.top, 24)
    }

    private func passportField(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(.system(size: 9, weight: .semibold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.6))
            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Saved

    private var savedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SAVED")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 28)

            VStack(spacing: 8) {
                savedRow(title: "Mahogany Hair Studio", subtitle: "salon · Brooklyn")
                savedRow(title: "Topicals Faded", subtitle: "product · A")
                savedRow(title: "Hyperpigmentation guide", subtitle: "article · 3d ago")
            }
        }
    }

    private func savedRow(title: String, subtitle: String) -> some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.mist)
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.ink)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.inkMuted)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Settings

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SETTINGS")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 28)
                .padding(.bottom, 4)

            ForEach([
                ("Edit skin profile", "update concerns", "person.crop.square"),
                ("My ritual", "morning & night", "moon.stars"),
                ("Privacy", "scans stay local", "lock"),
                ("Notifications", "scan reminders", "bell"),
            ], id: \.0) { title, subtitle, icon in
                settingsRow(title: title, subtitle: subtitle, icon: icon)
            }
        }
    }

    private func settingsRow(title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.mist)
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.accent)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.ink)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.inkMuted)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ProfileView()
}
