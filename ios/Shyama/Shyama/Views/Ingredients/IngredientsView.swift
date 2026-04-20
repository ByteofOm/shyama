import SwiftUI

struct IngredientsView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.canvas.ignoresSafeArea()

                VStack(spacing: 0) {
                    hero
                    searchBar
                    emptyState
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: - Hero

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            // Base: deep green gradient
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "091C11"), location: 0),
                    .init(color: Color(hex: "0E3D28"), location: 0.55),
                    .init(color: Color(hex: "1F1650"), location: 1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Iridescent spill from top-trailing corner
            RadialGradient(
                colors: [Color.white.opacity(0.14), .clear],
                center: .topTrailing,
                startRadius: 0,
                endRadius: 220
            )

            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    ShyamaLogoMark(color: .white, size: 22)
                    Text("SHYAMA")
                        .font(.system(size: 11, weight: .semibold, design: .default))
                        .tracking(3)
                        .foregroundStyle(Color.white.opacity(0.6))
                }

                Text("Know what's in\nyour products.")
                    .font(Font.Shyama.displayMedium)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
        .frame(height: 200)
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundStyle(Color.inkMuted)

            TextField("Search ingredient or scan a label", text: $searchText)
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
                    .foregroundStyle(Color.inkSoft)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .overlay(alignment: .bottom) {
            Color.stroke.frame(height: 0.5)
        }
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "sparkles")
                .font(.system(size: 36))
                .foregroundStyle(Color.inkMuted)

            Text("Search an ingredient to see if it works for you.")
                .font(Font.Shyama.footnote)
                .foregroundStyle(Color.inkMuted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)

            Spacer()
        }
    }
}

#Preview {
    IngredientsView()
}
