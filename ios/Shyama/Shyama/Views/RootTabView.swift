import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }

            IngredientsView()
                .tabItem {
                    Label("Ingredients", systemImage: "list.bullet.rectangle")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
        .tint(Color.amber)
    }
}

#Preview {
    RootTabView()
}
