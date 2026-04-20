import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house") }

            NavigationStack {
                MapView()
            }
            .tabItem { Label("Map", systemImage: "mappin.and.ellipse") }

            NavigationStack {
                ScanView()
            }
            .tabItem { Label("Scan", systemImage: "viewfinder.circle") }

            NavigationStack {
                IngredientsView()
            }
            .tabItem { Label("Products", systemImage: "bag") }

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
        .tint(Color.accent)
    }
}

#Preview {
    RootTabView()
}
