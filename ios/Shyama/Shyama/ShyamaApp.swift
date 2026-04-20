import SwiftUI

@main
struct ShyamaApp: App {
    init() {
        registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
