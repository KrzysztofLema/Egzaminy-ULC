import ComposableArchitecture
import CoreUI
import ExamsListFeature
import SharedViews
import SwiftUI

@ViewAction(for: Onboarding.self)
public struct OnboardingFeatureView: View {
    public var store: StoreOf<Onboarding>

    @ObserveInjection private var iO

    public var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()

            VStack {
                Spacer()

                stepsView

                Spacer()

                if store.isNextButtonVisible {
                    Button(action: {
                        send(.nextButtonTapped, animation: .default)
                    }, label: {
                        Text("Następne")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    })
                    .padding()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
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
                LabelView(text: Text("Witamy w aplikacji\n") + Text("Egzaminy ULC").bold())
            case .welcome2:
                LabelView(text: Text("Z nami uda Ci się zdać egzaminy w\n") + Text("Urzędzie Lotnictwa Cywilnego").bold())
            case .choseSubject:
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        LabelView(text: Text("Wybierz egzamin który Cię interesuje:"))
                            .frame(maxHeight: .infinity, alignment: .top)

                        ExamsListView(store: store.scope(state: \.examsList, action: \.examsList))
                    }
                }
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

public enum OnboardingSteps: Int, CaseIterable {
    case welcome
    case welcome2
    case choseSubject

    mutating func next() {
        let allCases = OnboardingSteps.allCases
        if let currentIndex = allCases.firstIndex(of: self),
           currentIndex + 1 < allCases.count {
            self = allCases[currentIndex + 1]
        }
    }

    func isLast() -> Bool {
        self == OnboardingSteps.allCases.last
    }
}
