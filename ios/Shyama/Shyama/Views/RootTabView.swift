import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "mappin.and.ellipse")
                }

            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "viewfinder.circle")
                }

            IngredientsView()
                .tabItem {
                    Label("Products", systemImage: "bag")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(Color.accent)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootTabView()
}
