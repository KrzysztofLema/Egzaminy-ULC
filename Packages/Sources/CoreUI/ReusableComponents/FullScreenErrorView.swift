import Providers
import SharedViews
import SwiftUI

public struct FullScreenErrorView: View {
    @ObserveInjection var io

    var icon: Image
    var title: String
    var subtitle: String?
    var imageSize: CGSize
    var closeButtonAction: (() -> Void)?

    public init(
        icon: Image = ImageProvider.Error.errorCloudCross,
        title: String = LocalizationProvider.Error.fullScreenTitle,
        subtitle: String? = LocalizationProvider.Error.fullScreenDescription,
        imageSize: CGSize = CGSize(width: 100, height: 100),
        closeButtonAction: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.imageSize = imageSize
        self.closeButtonAction = closeButtonAction
    }

    public var body: some View {
        ZStack {
            backgroundColor

            VStack {
                closeButton

                Spacer()

                content()

                Spacer()
            }
        }
        .enableInjection()
    }

    private func content() -> some View {
        VStack(spacing: 25) {
            iconImage
            labels
        }
    }

    private var iconImage: some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize.width, height: imageSize.height)
    }

    private var closeButton: some View {
        CircleButton(
            iconImage: Image(systemName: "xmark"),
            circleButtonAction: closeButtonAction
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }

    private var labels: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.primary)

            if let subtitle {
                Text(subtitle)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .multilineTextAlignment(.center)
    }

    private var backgroundColor: some View {
        Color.primaryBackground.ignoresSafeArea()
    }
}
