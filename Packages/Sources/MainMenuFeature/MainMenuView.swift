import ComposableArchitecture
import CoreUI
import ExamDetailFeature
import Providers
import SwiftUI

@ViewAction(for: MainMenu.self)
public struct MainMenuView: View {
    @Bindable public var store: StoreOf<MainMenu>

    public var body: some View {
        NavigationStack(path: $store.scope(
            state: \.path,
            action: \.path
        )) {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()

                VStack(spacing: 8) {
                    CustomMenuButton {
                        send(.didTapQuizButton)
                    } content: {
                        HStack(spacing: 20) {
                            Image(systemName: "menucard")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 32.0, height: 32.0)
                                .padding(5)

                            VStack(alignment: .leading, spacing: 12) {
                                Text("\(LocalizationProvider.MainMenu.quiz)")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }
                        }
                    }

                    CustomMenuButton {} content: {
                        HStack(spacing: 20) {
                            Image(systemName: "bookmark.circle")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 32.0, height: 32.0)
                                .padding(5)

                            VStack(alignment: .leading, spacing: 12) {
                                Text("\(LocalizationProvider.MainMenu.favoritesQuestions)")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding()
            }
        } destination: { store in
            switch store.case {
            case let .examDetail(store):
                ExamDetailView(store: store)
            }
        }
    }

    public init(store: StoreOf<MainMenu>) {
        self.store = store
    }
}
