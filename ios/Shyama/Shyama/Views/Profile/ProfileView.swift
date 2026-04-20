import SwiftUI

struct ProfileView: View {
    @State private var showEditProfile = false
    @State private var showRitual = false
    @State private var showPrivacy = false
    @State private var showNotifications = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                profileHeader
                statsRow
                passportCard
                savedSection
                settingsSection
                Spacer().frame(height: 40)
            }
            .padding(.horizontal, 22)
        }
        .background(Color.canvas.ignoresSafeArea())
        .sheet(isPresented: $showEditProfile) { editProfileSheet }
        .sheet(isPresented: $showPrivacy) { privacySheet }
        .sheet(isPresented: $showNotifications) { notificationsSheet }
    }

    // MARK: - Header

    private var profileHeader: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient.amberGlow)
                    .frame(width: 72, height: 72)
                Text("R")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.gradientStart)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Ruby Mendenhall")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(Color.ink)
                Text("4C hair · dry skin · sensitive")
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
        .padding(.bottom, 24)
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

    // MARK: - Skin Passport

    private var passportCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    colors: [Color(hex: "3C1A2E"), Color(hex: "C9643F")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))

            Canvas { ctx, sz in
                for row in stride(from: 0, to: sz.height, by: 36) {
                    for col in stride(from: 0, to: sz.width, by: 36) {
                        let cx = col + (row.truncatingRemainder(dividingBy: 72) == 0 ? 18 : 0)
                        let dot = Path(ellipseIn: CGRect(x: cx, y: row, width: 1.5, height: 1.5))
                        ctx.fill(dot, with: .color(.white.opacity(0.09)))
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("SHYAMA PASSPORT")
                            .font(.system(size: 9, weight: .semibold))
                            .tracking(2)
                            .foregroundStyle(.white.opacity(0.65))
                        Text("Ruby Mendenhall")
                            .font(.system(size: 22, weight: .bold, design: .serif))
                            .italic()
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    ShyamaLogoMark(color: .white.opacity(0.6), size: 32)
                }

                Divider().overlay(Color.white.opacity(0.2))

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    passportField(label: "HAIR", value: "Type 4C · coils")
                    passportField(label: "SKIN", value: "Dry · sensitive")
                    passportField(label: "FOCUS", value: "Dry skin · barrier")
                    passportField(label: "AVOID", value: "SLS, alcohol denat., synthetic fragrance, parabens, heavy retinoids")
                }
            }
            .padding(20)
        }
        .padding(.bottom, 24)
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
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Saved

    private var savedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("SAVED")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.inkMuted)
                Spacer()
                Button("See all") {}
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.accent)
            }

            VStack(spacing: 8) {
                NavigationLink(destination: Text("Crown & Curl Studio").navigationTitle("Salon Detail")) {
                    savedRow(title: "Crown & Curl Natural Hair", subtitle: "salon · Champaign · 4C specialist")
                }
                NavigationLink(destination: Text("Topicals Faded").navigationTitle("Product Detail")) {
                    savedRow(title: "Topicals Faded Serum", subtitle: "product · A grade")
                }
                NavigationLink(destination: Text("Hyperpigmentation").navigationTitle("Article")) {
                    savedRow(title: "Dry skin & 4C hair guide", subtitle: "article · 2d ago")
                }
            }
        }
        .padding(.bottom, 24)
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
                .font(.system(size: 11, weight: .medium))
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
                .padding(.bottom, 4)

            Button { showEditProfile = true } label: {
                settingsRow(title: "Edit skin profile", subtitle: "dry skin · 4C · sensitive", icon: "person.crop.square")
            }
            Button { showRitual = true } label: {
                settingsRow(title: "My ritual", subtitle: "skincare · mindfulness · nutrition", icon: "moon.stars")
            }
            Button { showNotifications = true } label: {
                settingsRow(title: "Notifications", subtitle: "scan reminders · appointment alerts", icon: "bell")
            }
            Button { showPrivacy = true } label: {
                settingsRow(title: "Privacy", subtitle: "scans stay local · data you control", icon: "lock")
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
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.inkMuted)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Sheets

    private var editProfileSheet: some View {
        NavigationStack {
            List {
                Section("Skin") {
                    LabeledContent("Type", value: "Dry · sensitive")
                    LabeledContent("Tone", value: "Deep brown")
                    LabeledContent("Concern", value: "Dry skin · barrier")
                }
                Section("Hair") {
                    LabeledContent("Texture", value: "Type 4C")
                    LabeledContent("Style", value: "Coils · natural")
                }
                Section("Avoid") {
                    Text("SLS, alcohol denat., synthetic fragrance, parabens, heavy retinoids without barrier prep")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.inkSoft)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { showEditProfile = false }
                }
            }
        }
    }

    private var privacySheet: some View {
        NavigationStack {
            List {
                Section("Data") {
                    Label("Scan photos stay on-device", systemImage: "iphone.and.arrow.right")
                    Label("No cloud upload without consent", systemImage: "cloud.slash")
                    Label("Delete all data anytime", systemImage: "trash")
                }
                Section("Analytics") {
                    Toggle("Anonymous usage data", isOn: .constant(false))
                }
            }
            .navigationTitle("Privacy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showPrivacy = false }
                }
            }
        }
    }

    private var notificationsSheet: some View {
        NavigationStack {
            List {
                Section("Reminders") {
                    Toggle("Daily ritual reminder (8am)", isOn: .constant(true))
                    Toggle("Scan reminder (every 2 days)", isOn: .constant(true))
                    Toggle("Appointment suggestions", isOn: .constant(true))
                }
                Section("Community") {
                    Toggle("New replies to my posts", isOn: .constant(false))
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showNotifications = false }
                }
            }
        }
    }
}

#Preview {
    NavigationStack { ProfileView() }
}
