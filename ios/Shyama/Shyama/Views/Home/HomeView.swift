import SwiftUI
import MapKit

struct HomeView: View {
    // Champaign IL, late April — replace with live WeatherKit when ready
    private let weatherTemp = 62
    private let weatherCondition = "Partly Cloudy"
    private let weatherWind = "14 mph"
    private let weatherHumidity = 71
    private let weatherUV = 3
    private let weatherAdvice = "Wind is drying your barrier today. Don't skip the ceramide — and SPF still matters through cloud cover."

    private let todayDate = "APR 20"

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                header
                healthTip
                weatherCard
                skinTodayCard
                ritualSection
                smartSuggested
                Spacer().frame(height: 40)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.canvas.ignoresSafeArea())
    }

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text("SHYAMA · \(todayDate)")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.inkMuted)
                    .padding(.top, 16)
                Text("Good morning,\nRuby.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(Color.ink)
            }
            Spacer()
            ShyamaLogoMark(color: Color.accent, size: 34)
                .padding(.top, 20)
        }
        .padding(.bottom, 20)
    }

    // MARK: - Health tip

    private var healthTip: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.accent)
                .frame(width: 3, height: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text("TODAY'S TIP")
                    .font(.system(size: 9, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.accent)
                Text("Dry skin responds to prevention, not rescue. Cleanse with cream, layer moisture, then seal — in that order.")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 14)
        .background(Color.accent.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
        .padding(.bottom, 16)
    }

    // MARK: - Weather card

    private var weatherCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("CHAMPAIGN, IL")
                        .font(.system(size: 9, weight: .semibold))
                        .tracking(2)
                        .foregroundStyle(Color.inkMuted)
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("\(weatherTemp)°F")
                            .font(.system(size: 32, weight: .bold, design: .serif))
                            .foregroundStyle(Color.ink)
                        Text(weatherCondition)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.inkSoft)
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    weatherStat(icon: "wind", value: weatherWind)
                    weatherStat(icon: "humidity.fill", value: "\(weatherHumidity)%")
                    weatherStat(icon: "sun.max", value: "UV \(weatherUV)")
                }
            }

            HStack(spacing: 8) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.accent)
                Text(weatherAdvice)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 4)
        }
        .padding(18)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
        .padding(.bottom, 16)
    }

    private func weatherStat(icon: String, value: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(Color.inkMuted)
            Text(value)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.inkSoft)
        }
    }

    // MARK: - Skin Today card

    private var skinTodayCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text("SKIN TODAY")
                            .font(.system(size: 9, weight: .semibold))
                            .tracking(2)
                            .foregroundStyle(Color.inkMuted)
                        Text("+ 3 pts")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.good)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.good.opacity(0.15), in: Capsule())
                    }

                    HStack(alignment: .center, spacing: 4) {
                        Text("B+")
                            .font(.system(size: 68, weight: .black, design: .serif))
                            .italic()
                            .foregroundStyle(Color.good)
                            .padding(.leading, -4)
                    }
                }
                Spacer()
                NavigationLink(destination: ScanView()) {
                    VStack(spacing: 4) {
                        ZStack {
                            Circle()
                                .fill(Color.accent.opacity(0.15))
                                .frame(width: 52, height: 52)
                            Image(systemName: "viewfinder.circle")
                                .font(.system(size: 26))
                                .foregroundStyle(Color.accent)
                        }
                        Text("Scan now")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.accent)
                    }
                }
                .padding(.top, 4)
            }

            Text("Hydration holding · barrier strong")
                .font(.system(size: 13))
                .foregroundStyle(Color.inkSoft)
                .padding(.top, 2)

            Text("Last scan · 2 days ago")
                .font(.system(size: 11))
                .foregroundStyle(Color.inkMuted)
                .padding(.top, 2)

            // Progress bars
            HStack(spacing: 6) {
                ForEach([("Hydration", 0.82), ("Barrier", 0.74), ("Pigmentation", 0.6), ("Inflammation", 0.35)], id: \.0) { label, val in
                    VStack(alignment: .leading, spacing: 3) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(val > 0.5 ? Color.good : Color.warn)
                            .frame(height: 5)
                            .opacity(Double(val))
                        Text(label)
                            .font(.system(size: 8))
                            .foregroundStyle(Color.inkMuted)
                    }
                }
            }
            .padding(.top, 14)
        }
        .padding(18)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
        .padding(.bottom, 16)
    }

    // MARK: - Today's ritual

    private var ritualSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TODAY'S RITUAL")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)

            VStack(spacing: 8) {
                ritualRow(icon: "sparkles", title: "Gentle cream cleanse", subtitle: "No sulfates — keeps barrier intact", done: true, category: "Skincare")
                ritualRow(icon: "sun.max.fill", title: "SPF 50 — mineral", subtitle: "UV 3 today · still needed under clouds", done: false, category: "Skincare")
                ritualRow(icon: "lungs.fill", title: "5 min box breathing", subtitle: "Cortisol spikes trigger dry-skin flares", done: false, category: "Mindfulness")
                ritualRow(icon: "fork.knife", title: "Omega-3 rich meal", subtitle: "Fatty fish, walnuts, or flaxseed — feeds dry skin from inside", done: false, category: "Nutrition")
                ritualRow(icon: "moon.stars.fill", title: "Evening barrier seal", subtitle: "Apply ceramide + face oil on damp skin", done: false, category: "Skincare")
            }
        }
        .padding(.bottom, 24)
    }

    private func ritualRow(icon: String, title: String, subtitle: String, done: Bool, category: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 11)
                    .fill(done ? Color.stroke : categoryColor(category).opacity(0.15))
                    .frame(width: 42, height: 42)
                Image(systemName: icon)
                    .font(.system(size: 17))
                    .foregroundStyle(done ? Color.inkMuted : categoryColor(category))
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(done ? Color.inkMuted : Color.ink)
                    .strikethrough(done, color: Color.inkMuted)
                Text(subtitle)
                    .font(.system(size: 10))
                    .foregroundStyle(Color.inkMuted)
            }

            Spacer()

            Text(category)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(categoryColor(category))
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(categoryColor(category).opacity(0.12), in: Capsule())
        }
        .padding(13)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 14))
        .opacity(done ? 0.65 : 1)
    }

    private func categoryColor(_ cat: String) -> Color {
        switch cat {
        case "Mindfulness": return Color(hex: "7B68EE")
        case "Nutrition": return Color.good
        default: return Color.accent
        }
    }

    // MARK: - Smart Suggested

    private var smartSuggested: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SMART SUGGESTED")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)

            suggestedCard(
                eyebrow: "💅 52 DAYS SINCE YOUR LAST NAIL VISIT",
                headline: "Time to treat yourself.",
                detail: "Mahogany Beauty Lounge in Champaign has openings this weekend. BIPOC-owned · BIPOC-friendly service menu.",
                grade: "A−",
                action: "Book Saturday →"
            )

            suggestedCard(
                eyebrow: "✂️ 4C HAIR THRIVES ON 6-WEEK TRIMS",
                headline: "Last visit: 9 weeks ago.",
                detail: "Crown & Curl Natural Hair Studio specializes in 4C locs and coils. 0.6 mi from downtown Champaign.",
                grade: "A",
                action: "See availability →"
            )
        }
        .padding(.bottom, 8)
    }

    private func suggestedCard(eyebrow: String, headline: String, detail: String, grade: String, action: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(eyebrow)
                .font(.system(size: 9, weight: .semibold))
                .tracking(1)
                .foregroundStyle(Color.accent)

            HStack {
                Text(headline)
                    .font(.system(size: 16, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.ink)
                Spacer()
                Text(grade)
                    .font(.system(size: 28, weight: .black, design: .serif))
                    .italic()
                    .foregroundStyle(Color.good)
            }

            Text(detail)
                .font(.system(size: 12))
                .foregroundStyle(Color.inkSoft)
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {}) {
                Text(action)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.canvas)
                    .frame(maxWidth: .infinity)
                    .frame(height: 42)
                    .background(Color.accent, in: Capsule())
            }
        }
        .padding(16)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    NavigationStack { HomeView() }
}
