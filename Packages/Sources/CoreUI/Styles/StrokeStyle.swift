import SwiftUI

struct GradientStrokeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                ).stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.6 : 0.3),
                        ],
                        startPoint: .bottom,
                        endPoint: .leading
                    )
                ).blendMode(.overlay)
            )
    }
}

extension View {
    public func applyGradientStroke(cornerRadius: CGFloat = 0.0) -> some View {
        modifier(GradientStrokeModifier(cornerRadius: cornerRadius))
    }
}
