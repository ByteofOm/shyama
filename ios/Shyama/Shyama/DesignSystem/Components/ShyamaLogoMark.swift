import SwiftUI

/// Minimal brand silhouette: natural-hair crown + face oval.
/// Scales cleanly from 20pt (tab bar) up to 120pt (splash use).
struct ShyamaLogoMark: View {
    var color: Color = .white
    var size: CGFloat = 44

    var body: some View {
        Canvas { ctx, sz in
            let w = sz.width
            let h = sz.height

            // Crown / natural hair — rounded top, softer bottom corners
            let hairRect = CGRect(x: w * 0.06, y: h * 0.02,
                                  width: w * 0.88, height: h * 0.50)
            let hairPath = UnevenRoundedRectangle(
                topLeadingRadius: w * 0.44,
                bottomLeadingRadius: w * 0.10,
                bottomTrailingRadius: w * 0.10,
                topTrailingRadius: w * 0.44
            ).path(in: hairRect)
            ctx.fill(hairPath, with: .color(color))

            // Face oval — overlaps hair base to merge into one silhouette
            let faceRect = CGRect(x: w * 0.24, y: h * 0.38,
                                  width: w * 0.52, height: h * 0.56)
            ctx.fill(Path(ellipseIn: faceRect), with: .color(color))
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    HStack(spacing: 24) {
        ShyamaLogoMark(color: .white, size: 28)
        ShyamaLogoMark(color: .white, size: 44)
        ShyamaLogoMark(color: .white, size: 72)
    }
    .padding(32)
    .background(Color.gradientStart)
}
