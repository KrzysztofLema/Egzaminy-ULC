import Inject
import Providers
import SwiftUI

public struct FullScreenLoaderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isLoading: Bool = false
    @State private var dashPhase: CGFloat = 0

    private var title: String = "Loading"
    private var subtitle: String? = "We’re loading your data. Please wait a moment."
    private var closeButtonAction: (() -> Void)?
    
    public var body: some View {
        ZStack {
            backgroundColor
            VStack {
                closeButton
                Spacer()
                content
                Spacer()
            }
        }
        .onAppear(
            perform: {
                withAnimation(
                    .linear(
                        duration: 3
                    ).repeatForever(
                        autoreverses: false
                    )
                ) {
                    startLoadingAnimation()
                }
            })
    }
    
    public init(
        title: String = LocalizationProvider.Loading.fullScreenLoadingTitle,
        subtitle: String? = LocalizationProvider.Loading.fullScreenLoadingDescription,
        closeButtonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.closeButtonAction = closeButtonAction
    }
    
    private var backgroundColor: some View {
        Color.primaryBackground.ignoresSafeArea()
    }
    
    private var content: some View {
        VStack(spacing: 25) {
            animatedIconImage
            labels
        }
    }
    
    private var closeButton: some View {
        CircleButton(
            iconImage: Image(systemName: "xmark"),
            circleButtonAction: closeButtonAction
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }
    
    private var animatedIconImage: some View {
        ZStack {
            paperPlaneicon
            cicleIconWithAnimation
        }
    }
    
    private var paperPlaneicon: some View {
        Image(systemName: "paperplane")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(
                Color.loaderAnimationIconForegroundColor
            )
    }
    
    private var cicleIconWithAnimation: some View {
        Circle()
            .stroke(
                LinearGradient(
                    gradient: Color.loaderAnimationCircleGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                ), style: StrokeStyle(
                    lineWidth: 5,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 0,
                    dash: [120, 20, 50, 220],
                    dashPhase: 320
                )
            )
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .frame(width: 100, height: 100)
    }
    
    private var labels: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
            
            if let subtitle {
                HStack(spacing: 0) {
                    Text(subtitle)
                }
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
            }
        }
        .multilineTextAlignment(.center)
    }
    
    @MainActor
    private func startLoadingAnimation() {
        isLoading = true
        dashPhase = 320
    }
}

#Preview {
    FullScreenLoaderView {
        
    }
}
