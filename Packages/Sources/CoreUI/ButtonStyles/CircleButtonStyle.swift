import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.regular))
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial, in: Circle())
            .animation(
                .easeInOut(duration: 0.2),
                value: configuration.isPressed
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
