import ComposableArchitecture
import CoreUI
import ExamsListFeature
import Providers

@ViewAction(for: Onboarding.self)
public struct OnboardingFeatureView: View {
    @Bindable public var store: StoreOf<Onboarding>

    @ObserveInjection private var iO

    public var body: some View {
        NavigationStack(path: $store.scope(
            state: \.path,
            action: \.path
        )) {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                VStack {
                    Spacer()
                    stepsView
                    Spacer()
                    Button(action: {
                        send(.nextButtonTapped, animation: .default)
                    }, label: {
                        Text("\(LocalizationProvider.Onboarding.nextOnboardingButton)")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    })
                    .padding()
                }
            }
        } destination: { store in
            switch store.case {
            case let .examList(store):
                ExamsListView(store: store)
            }
        }
        .enableInjection()
    }

    public init(store: StoreOf<Onboarding>) {
        self.store = store
    }

    var stepsView: some View {
        Group {
            switch store.onboardingSteps {
            case .welcome:
                LabelView(
                    text: Text("\(LocalizationProvider.Onboarding.welcomeToApp)\n") +
                        Text("\(LocalizationProvider.Onboarding.applicationTitle)").bold()
                )
            case .welcome2:
                LabelView(
                    text: Text("\(LocalizationProvider.Onboarding.withUsYouWillPass)\n") +
                        Text("\(LocalizationProvider.Onboarding.civilAviationAuthority)").bold()
                )
            case .choseSubject:
                LabelView(text: Text("\(LocalizationProvider.Onboarding.chooseExam)"))
            }
        }
        .transition(.opacity)
        .zIndex(1)
        .lineSpacing(5)
    }
}

struct LabelView: View {
    let text: Text

    init(text: Text) {
        self.text = text
    }

    var body: some View {
        text
            .padding(10)
            .font(.title)
    }
}
