import SwiftUI

struct SoftCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.canvas)
            )
            // Border ensures the card edge is perceptible without relying on shadow alone
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.ink.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: .white.opacity(0.6), radius: 4, x: -4, y: -4)
            .shadow(color: Color.ink.opacity(0.12), radius: 6, x: 6, y: 6)
    }
}

// MARK: - Preview

#Preview {
    SoftCard {
        VStack(spacing: Spacing.xs) {
            Image(systemName: "sparkles")
                .font(.system(size: 24))
                .foregroundStyle(Color.terracotta)
            Text("Ingredients")
                .font(Font.Shyama.caption)
                .foregroundStyle(Color.inkSoft)
        }
        .frame(width: 100)
    }
    .padding()
    .background(Color.canvas)
}
