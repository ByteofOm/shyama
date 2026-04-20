import SwiftUI

struct ResultsView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()
            Text("Results")
                .font(Font.Shyama.headline)
                .foregroundStyle(Color.inkSoft)
        }
        .navigationTitle("Results")
    }
}

#Preview { ResultsView() }
