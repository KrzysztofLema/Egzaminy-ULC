import SharedModels
import SharedViews
import SwiftUI

struct PostView: View {
    @ObserveInjection var iO
    @Bindable var model: PostModel
    var animationSettings: BetaSettings.Animations

    var body: some View {
        ZStack {
            frontCard
                .padding(5)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.yellow))
                .modifier(FlipOpacity(pct: model.isOpen ? 0 : 1))
                .rotation3DEffect(Angle.degrees(model.isOpen ? 180 : 360), axis: (0, 1, 0))

            backCard
                .padding(5)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color.yellow))
                .modifier(FlipOpacity(pct: model.isOpen ? 1 : 0))
                .rotation3DEffect(Angle.degrees(model.isOpen ? 0 : 180), axis: (0, 1, 0))
        }
        .enableInjection()
    }

    @ViewBuilder
    private var backCard: some View {
        VStack {
            Text(model.post.subtitle)
                .font(.headline)

            Button("Hide") {
                withAnimation(animationSettings.postOpeningAnimation) {
                    model.isOpen = false
                }
            }
            .foregroundColor(.green)
            .bold()
            .buttonStyle(.bordered)
        }
    }

    @ViewBuilder
    private var frontCard: some View {
        VStack {
            Text(model.post.title)
                .font(.headline)

            Button("Reveal") {
                withAnimation(animationSettings.postOpeningAnimation) {
                    model.isOpen = true
                }
            }
            .foregroundColor(.green)
            .bold()
            .buttonStyle(.bordered)
        }
    }
}

struct FlipOpacity: AnimatableModifier {
    var pct: CGFloat = 0

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func body(content: Content) -> some View {
        content.opacity(Double(pct.rounded()))
    }
}

extension BetaSettings.Animations {
    var postOpeningAnimation: Animation {
        switch postOpeningCurve {
        case .linear:
            Animation.linear(duration: postOpeningSpeed)
        case .easeInOut:
            Animation.easeInOut(duration: postOpeningSpeed)
        case .easeOut:
            Animation.easeOut(duration: postOpeningSpeed)
        }
    }
}
