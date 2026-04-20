import SwiftUI

/// The Shyama triple-moon brand mark (triple goddess symbol).
/// Uses template rendering so any Color can be applied via `color`.
struct ShyamaLogoMark: View {
    var color: Color = .white
    var size: CGFloat = 44

    var body: some View {
        Image("ShyamaLogoWhite")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .foregroundStyle(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    HStack(spacing: 24) {
        ShyamaLogoMark(color: .white, size: 28)
        ShyamaLogoMark(color: Color(hex: "E8A54B"), size: 44)
        ShyamaLogoMark(color: .white, size: 72)
    }
    .padding(40)
    .background(Color.canvas)
}
