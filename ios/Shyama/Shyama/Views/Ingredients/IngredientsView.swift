import SwiftUI

struct IngredientsView: View {
    @State private var searchText = ""
    @State private var selectedCategory: ProductCategory = .forMe

    private var filteredProducts: [ProductItem] {
        let byCategory = ProductItem.catalog.filter { $0.tagCategory == selectedCategory }
        if searchText.isEmpty { return byCategory }
        return byCategory.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.brand.localizedCaseInsensitiveContains(searchText) ||
            $0.tags.contains { $0.localizedCaseInsensitiveContains(searchText) } ||
            $0.ingredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            hero
            searchBar
            categoryChips
            productList
        }
        .background(Color.canvas.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Hero

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "1A0E26"), location: 0),
                    .init(color: Color(hex: "3C1A2E"), location: 0.5),
                    .init(color: Color(hex: "C9643F").opacity(0.7), location: 1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [Color(hex: "E8A54B").opacity(0.28), .clear],
                center: .topTrailing,
                startRadius: 0,
                endRadius: 250
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    ShyamaLogoMark(color: .white, size: 20)
                    Text("SHYAMA · PRODUCTS")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(3)
                        .foregroundStyle(.white.opacity(0.6))
                }

                Text("Graded A–F\nfor your skin.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Every score built for melanin-rich skin & textured hair.")
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 24)
        }
        .frame(height: 210)
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
                .foregroundStyle(Color.inkMuted)

            TextField("Search ingredient, brand, or concern", text: $searchText)
                .font(Font.Shyama.body)
                .foregroundStyle(Color.ink)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.inkMuted)
                }
            } else {
                Button { } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.accent)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(Color.surface)
        .overlay(alignment: .bottom) {
            Color.stroke.frame(height: 0.5)
        }
    }

    // MARK: - Category chips (reactive filter)

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ProductCategory.allCases, id: \.self) { cat in
                    Button {
                        withAnimation(.spring(response: 0.25)) {
                            selectedCategory = cat
                        }
                    } label: {
                        Text(cat.rawValue)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(selectedCategory == cat ? Color(hex: "F4EBDE") : Color.inkSoft)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                selectedCategory == cat ? Color.accent : Color.surface,
                                in: Capsule()
                            )
                    }
                    .animation(.spring(response: 0.25), value: selectedCategory)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.canvas)
    }

    // MARK: - Product list

    private var productList: some View {
        ScrollView(showsIndicators: false) {
            if filteredProducts.isEmpty {
                emptyState
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            productRow(product)
                        }
                    }
                    Spacer().frame(height: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
            }
        }
    }

    private func productRow(_ product: ProductItem) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(
                    colors: [Color(hex: "3C1A2E").opacity(0.18), Color(hex: "C9643F").opacity(0.08)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.brand)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.inkMuted)
                Text(product.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.ink)
                    .lineLimit(1)

                // Reactive tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(product.tags, id: \.self) { tag in
                            Button {
                                withAnimation(.spring(response: 0.25)) {
                                    searchText = tag
                                }
                            } label: {
                                Text(tag)
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(Color.inkMuted)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.mist, in: RoundedRectangle(cornerRadius: 4))
                            }
                        }
                    }
                }

                // EDC indicator
                if product.ingredients.contains(where: { $0.isEDC }) {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 9))
                            .foregroundStyle(Color.warn)
                        Text("Contains EDCs — tap to learn")
                            .font(.system(size: 9, weight: .medium))
                            .foregroundStyle(Color.warn)
                    }
                }
            }

            Spacer()

            VStack(spacing: 0) {
                Text(product.grade)
                    .font(.system(size: 26, weight: .black, design: .serif))
                    .italic()
                    .foregroundStyle(gradeColor(product.grade))
                Text("\(product.score)")
                    .font(.system(size: 9))
                    .foregroundStyle(Color.inkMuted)
            }
        }
        .padding(14)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 60)
            Image(systemName: "sparkles")
                .font(.system(size: 36))
                .foregroundStyle(Color.inkMuted)
            Text("No products match \"\(searchText)\"")
                .font(Font.Shyama.footnote)
                .foregroundStyle(Color.inkMuted)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

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
    NavigationStack { IngredientsView() }
}
