import SwiftUI

// Named MapView to match the folder; does not import MapKit yet.
struct MapView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()
            Text("Find Care")
                .font(Font.Shyama.headline)
                .foregroundStyle(Color.inkSoft)
        }
        .navigationTitle("Find Care")
    }
}

#Preview { MapView() }
