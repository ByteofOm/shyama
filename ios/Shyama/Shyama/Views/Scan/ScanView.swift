import SwiftUI

struct ScanView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.canvas.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    Image(systemName: "camera.viewfinder")
                        .font(.system(size: 80))
                        .foregroundStyle(Color.inkMuted)

                    Spacer().frame(height: 24)

                    Text("Scan your skin")
                        .font(Font.Shyama.displayMedium)
                        .foregroundStyle(Color.ink)

                    Spacer().frame(height: 16)

                    Text("Get possible matches and skin tips for conditions commonly seen on melanated skin. Educational — always consult a dermatologist.")
                        .font(Font.Shyama.callout)
                        .foregroundStyle(Color.inkSoft)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)

                    Spacer().frame(height: 48)

                    GlassCTAButton("Open camera", icon: "camera") {
                        print("Camera pressed")
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ScanView()
}
