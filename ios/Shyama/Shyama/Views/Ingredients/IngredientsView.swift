import SwiftUI

struct IngredientsView: View {
    @State private var searchText = ""
    @State private var selectedCategory = 0

    private let categories = ["For me", "Trending", "New", "Melanin-tested"]
    private let products: [(brand: String, name: String, grade: String, score: String, tags: [String])] = [
        ("Topicals", "Faded Serum", "A", "94", ["hyperpigmentation", "4c-safe"]),
        ("Fenty Skin", "Fat Water Toner", "A", "96", ["fragrance-free", "deep skin"]),
        ("Eadem", "Milk Marvel Serum", "A", "93", ["brightening", "melanin-safe"]),
        ("Bread Beauty", "Hair Oil", "A−", "88", ["locs-safe", "castor"]),
        ("The Ordinary", "Niacinamide 10%", "B+", "84", ["barrier", "oily"]),
    ]

    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()

            VStack(spacing: 0) {
                hero
                searchBar
                categoryChips
                productList
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .preferredColorScheme(.dark)
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
                colors: [Color.accent.opacity(0.3), .clear],
                center: .topTrailing,
                startRadius: 0,
                endRadius: 250
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    ShyamaLogoMark(color: .white, size: 20)
                    Text("SHYAMA")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(3)
                        .foregroundStyle(Color.white.opacity(0.6))
                }

                Text("Products\nfor your skin.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Graded A–F for melanin-rich skin & textured hair.")
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 24)
        }
        .frame(height: 220)
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
                .foregroundStyle(Color.inkMuted)

            TextField("Search ingredient or brand", text: $searchText)
                .font(Font.Shyama.body)
                .foregroundStyle(Color.ink)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            Spacer()

            Button {
                print("Barcode scanner")
            } label: {
                Image(systemName: "barcode.viewfinder")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.accent)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(Color.surface)
        .overlay(alignment: .bottom) {
            Color.stroke.frame(height: 0.5)
        }
    }

    // MARK: - Category chips

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories.indices, id: \.self) { i in
                    Button {
                        selectedCategory = i
                    } label: {
                        Text(categories[i])
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(selectedCategory == i ? Color.canvas : Color.inkSoft)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                selectedCategory == i ? Color.accent : Color.surface,
                                in: Capsule()
                            )
                    }
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
            LazyVStack(spacing: 10) {
                ForEach(products, id: \.name) { product in
                    productRow(product)
                }
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 16)
            .padding(.top, 4)
        }
    }

    private func productRow(_ product: (brand: String, name: String, grade: String, score: String, tags: [String])) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(
                    colors: [Color.mist, Color.surface],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.brand)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.inkMuted)
                Text(product.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.ink)
                HStack(spacing: 4) {
                    ForEach(product.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundStyle(Color.inkMuted)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.mist, in: RoundedRectangle(cornerRadius: 4))
                    }
                }
            }

            Spacer()

            VStack(spacing: 0) {
                gradeColor(product.grade)
                Text(product.score)
                    .font(.system(size: 9))
                    .foregroundStyle(Color.inkMuted)
            }
        }
        .padding(14)
        .background(Color.surface, in: RoundedRectangle(cornerRadius: 16))
    }

    private func gradeColor(_ grade: String) -> some View {
        let color: Color = grade.hasPrefix("A") ? .good : grade.hasPrefix("B") ? Color(hex: "8FB57A") : .warn
        return Text(grade)
            .font(.system(size: 24, weight: .bold, design: .serif))
            .italic()
            .foregroundStyle(color)
    }
}

#Preview {
    IngredientsView()
}
