import SwiftUI

struct ScanView: View {
    var body: some View {
        ZStack {
            Color.canvas.ignoresSafeArea()
            Text("Scan")
                .font(Font.Shyama.headline)
                .foregroundStyle(Color.inkSoft)
        }
        .navigationTitle("Scan")
    }
}

#Preview { ScanView() }
