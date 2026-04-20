import SwiftUI

struct IngredientsView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.canvas.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    Image(systemName: "sparkles")
                        .font(.system(size: 60))
                        .foregroundStyle(Color.amber.opacity(0.75))

                    Spacer().frame(height: 20)

                    Text("Know what's in your products")
                        .font(.custom("Fraunces-9ptBlack", size: 22).weight(.medium))
                        .foregroundStyle(Color.ink)
                        .multilineTextAlignment(.center)

                    Spacer().frame(height: 12)

                    Text("Check if an ingredient is friendly to melanated skin and textured hair, and whether a brand is genuinely inclusive.")
                        .font(.custom("DMSans-9ptRegular", size: 14))
                        .foregroundStyle(Color.inkSoft)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)

                    Spacer()
                }
            }
            .navigationTitle("Ingredients")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search an ingredient or scan a label"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Barcode scanner")
                    } label: {
                        Image(systemName: "barcode.viewfinder")
                            .foregroundStyle(Color.inkSoft)
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientsView()
}
