import SwiftUI

struct IngredientsView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()
            Text("Ingredients")
                .font(Font.Shyama.headline)
                .foregroundStyle(Color.inkSoft)
        }
        .navigationTitle("Ingredients")
    }
}

#Preview { IngredientsView() }
