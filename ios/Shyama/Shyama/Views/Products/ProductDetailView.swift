import SwiftUI

struct ProductDetailView: View {
    let product: ProductItem
    @State private var showEDCInfo = false
    @Environment(\.dismiss) private var dismiss

    private var edcIngredients: [ProductIngredient] {
        product.ingredients.filter { $0.isEDC }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                gradeSection
                breakdownSection
                if !edcIngredients.isEmpty { edcWarningSection }
                ingredientsSection
                addButton
                disclaimer
                Spacer().frame(height: 32)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.canvas.ignoresSafeArea())
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(Color.accent)
                }
            }
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    colors: [Color(hex: "3C1A2E").opacity(0.3), Color(hex: "C9643F").opacity(0.15)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))
                .frame(width: 90, height: 120)

            VStack(alignment: .leading, spacing: 6) {
                Text(product.brand.uppercased())
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.inkMuted)
                Text(product.name)
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .italic()
                    .foregroundStyle(Color.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Text(product.description)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.inkSoft)
                    .lineLimit(3)
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 20)
    }

    // MARK: - Overall grade

    private var gradeSection: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(spacing: 2) {
                Text(product.grade)
                    .font(.system(size: 80, weight: .black, design: .serif))
                    .italic()
                    .foregroundStyle(gradeColor(product.grade))
                Text("MELANIN-SAFE SCORE")
                    .font(.system(size: 9, weight: .semibold))
                    .tracking(1.5)
                    .foregroundStyle(Color.inkMuted)
            }

            VStack(alignment: .leading, spacing: 8) {
                scoreBadge(label: "Ingredient safety", value: "\(product.score)/100")
                scoreBadge(label: "Dry skin match", value: product.score > 90 ? "Excellent" : product.score > 80 ? "Good" : "Moderate")
                scoreBadge(label: "Built for Ruby", value: product.tags.contains("dry skin") || product.tags.contains("4c-safe") ? "Yes" : "Partial")

                HStack(spacing: 6) {
                    ForEach(product.tags.prefix(3), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundStyle(Color.inkMuted)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.mist, in: RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
        }
        .padding(18)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
        .padding(.bottom, 16)
    }

    private func scoreBadge(label: String, value: String) -> some View {
        HStack(spacing: 6) {
            Text(label)
                .font(.system(size: 11))
                .foregroundStyle(Color.inkMuted)
            Spacer()
            Text(value)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.ink)
        }
    }

    // MARK: - Score breakdown bars

    private var breakdownSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SCORE BREAKDOWN")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)

            let breakdown: [(String, Double, String)] = [
                ("Ingredient quality", Double(product.score) / 100, product.grade),
                ("Dry skin safety", min(Double(product.score + 4) / 100, 1.0), product.score > 90 ? "A" : "B+"),
                ("Barrier friendliness", min(Double(product.score - 6) / 100, 1.0), product.score > 88 ? "A−" : "B"),
                ("Community (similar profiles)", min(Double(product.score + 2) / 100, 1.0), product.score > 92 ? "A" : "A−"),
            ]

            VStack(spacing: 10) {
                ForEach(breakdown, id: \.0) { label, pct, grade in
                    HStack(spacing: 12) {
                        Text(grade)
                            .font(.system(size: 18, weight: .black, design: .serif))
                            .italic()
                            .foregroundStyle(gradeColor(grade))
                            .frame(width: 28, alignment: .leading)
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(label)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.ink)
                                Spacer()
                                Text("\(Int(pct * 100))/100")
                                    .font(.system(size: 10))
                                    .foregroundStyle(Color.inkMuted)
                            }
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.stroke)
                                        .frame(height: 4)
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(gradeColor(grade))
                                        .frame(width: geo.size.width * pct, height: 4)
                                }
                            }
                            .frame(height: 4)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
        .padding(.bottom, 16)
    }

    // MARK: - EDC Warning

    private var edcWarningSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.warn)
                Text("EDC WATCH")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundStyle(Color.warn)
                Spacer()
                Button { showEDCInfo.toggle() } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.inkMuted)
                }
            }

            Text("Endocrine-disrupting chemicals (EDCs) are ingredients that may interfere with hormone function. They're especially worth tracking with dry skin and high-absorption areas.")
                .font(.system(size: 11))
                .foregroundStyle(Color.inkSoft)
                .fixedSize(horizontal: false, vertical: true)

            ForEach(edcIngredients) { ing in
                HStack(alignment: .top, spacing: 12) {
                    Text("!")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Color.warn)
                        .frame(width: 24)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(ing.name)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.ink)
                        if let note = ing.edcNote {
                            Text(note)
                                .font(.system(size: 11))
                                .foregroundStyle(Color.inkSoft)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(12)
                .background(Color.warn.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(16)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 18))
        .padding(.bottom, 16)
    }

    // MARK: - Full ingredient list

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("INGREDIENTS, GRADED")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundStyle(Color.inkMuted)

            VStack(spacing: 8) {
                ForEach(product.ingredients) { ing in
                    HStack(alignment: .top, spacing: 12) {
                        Text(ing.grade)
                            .font(.system(size: 16, weight: .black, design: .serif))
                            .italic()
                            .foregroundStyle(gradeColor(ing.grade))
                            .frame(width: 30, alignment: .leading)

                        VStack(alignment: .leading, spacing: 3) {
                            HStack(spacing: 6) {
                                Text(ing.name)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(Color.ink)
                                if ing.isEDC {
                                    Text("EDC")
                                        .font(.system(size: 8, weight: .bold))
                                        .foregroundStyle(Color.warn)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Color.warn.opacity(0.15), in: Capsule())
                                }
                            }
                            Text(ing.function_)
                                .font(.system(size: 11))
                                .foregroundStyle(Color.inkMuted)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(ing.isEDC ? Color.warn.opacity(0.06) : Color.surface, in: RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .padding(.bottom, 16)
    }

    // MARK: - Add to ritual

    private var addButton: some View {
        Button {} label: {
            Text("Add to ritual")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color(hex: "F4EBDE"))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.accent, in: Capsule())
        }
        .padding(.bottom, 12)
    }

    private var disclaimer: some View {
        HStack(spacing: 8) {
            Image(systemName: "info.circle")
                .font(.system(size: 11))
                .foregroundStyle(Color.inkMuted)
            Text("Educational only. For personal medical advice, consult a dermatologist who works with darker skin tones.")
                .font(.system(size: 11))
                .foregroundStyle(Color.inkMuted)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 8)
    }

    // MARK: - Grade color helper

    private func gradeColor(_ grade: String) -> Color {
        switch grade.prefix(1) {
        case "A": return .good
        case "B": return Color(hex: "7AAA68")
        case "C": return .warn
        default:  return .bad
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: ProductItem.topicalsFaded)
    }
}
