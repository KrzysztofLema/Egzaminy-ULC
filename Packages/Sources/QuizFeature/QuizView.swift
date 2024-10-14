import ComposableArchitecture
import CoreUI
import Providers
import SharedModels
import SharedViews
import SwiftUI

@ViewAction(for: Quiz.self)
public struct QuizView: View {
    @ObserveInjection private var iO

    public var store: StoreOf<Quiz>

    @State var isBookmarkSelected = false

    public var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()

            VStack {
                HStack {
                    bookmarkButton
                    Spacer()
                    titleText
                    Spacer()
                    closeButton
                }
                .padding()

                Spacer(minLength: 5)

                ScrollView(showsIndicators: false) {
                    VStack {
                        QuestionView(questionTitle: store.currentQuestion?.title)

                        ForEachStore(store.scope(state: \.answers, action: \.answers)) { store in
                            AnswerView(store: store)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial)
                    )
                    .padding(16)
                    .frame(maxHeight: .infinity)
                }

                Button(action: {
                    send(.nextQuestionButtonTapped)
                }, label: {
                    Text("\(LocalizationProvider.Quiz.nextQuestion)")
                        .foregroundColor(store.isNextButtonEnabled ? .white : .gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10))
                        .padding()
                })
                .disabled(!store.isNextButtonEnabled)
                .padding()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear(perform: {
            send(.onViewAppear)
        })
        .alert(store: store.scope(state: \.$alert, action: \.alert))
        .enableInjection()
    }

    var closeButton: some View {
        Button {
            send(.closeQuizButtonTapped)
        } label: {
            Image(systemName: "xmark")
                .asQuizIcon()
                .background(.ultraThinMaterial, in: Circle())
        }
    }

    var bookmarkButton: some View {
        Button {
            isBookmarkSelected.toggle()
        } label: {
            Image(systemName: isBookmarkSelected ? "bookmark" : "bookmark.fill")
                .asQuizIcon()
                .animation(.easeInOut(duration: 0.1), value: isBookmarkSelected)
        }
    }

    var titleText: some View {
        Text(store.subject.title ?? "")
            .font(.headline)
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }

    public init(store: StoreOf<Quiz>) {
        self.store = store
    }
}

private extension View {
    func asQuizIcon() -> some View {
        font(.body.weight(.regular))
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial, in: Circle())
    }
}

struct QuestionView: View {
    var questionTitle: String?

    var body: some View {
        Text(questionTitle ?? "")
            .font(.system(.headline))
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding(30)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .padding(.bottom, 10)
    }
}
