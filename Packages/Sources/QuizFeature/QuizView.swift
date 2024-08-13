import ComposableArchitecture
import SharedModels
import SharedViews
import SwiftUI

@ViewAction(for: Quiz.self)
public struct QuizView: View {
    @ObserveInjection private var iO
    @Bindable public var store: StoreOf<Quiz>

    @State var isBookmarkSelected = false

    public var body: some View {
        VStack(spacing: 20) {
            HStack {
                bookmarkButton
                Spacer()
                titleText
                Spacer()
                closeButton
            }

            VStack {
                Text(store.questions[store.presentedQuestionNumber].title)
                    .font(.title3.width(.condensed))
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding(30)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.bottom, 35)
                    .layoutPriority(1)

                ForEachStore(store.scope(state: \.answers, action: \.answers)) { store in
                    AnswerView(store: store)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial)
            )

            Spacer()

            Button(action: {
                send(.nextQuestionButtonTapped)
            }, label: {
                Text("Następne")
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear(perform: {
            send(.onViewLoad)
        })
        .enableInjection()
    }

    var closeButton: some View {
        Button {
            send(.closeQuizButtonTapped)
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.regular))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
    }

    var bookmarkButton: some View {
        Button {
            isBookmarkSelected.toggle()
        } label: {
            Image(systemName: isBookmarkSelected ? "bookmark" : "bookmark.fill")
                .font(.body.weight(.regular))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
                .animation(.easeInOut(duration: 0.1), value: isBookmarkSelected)
        }
    }

    var titleText: some View {
        Text("Zasady Lotu")
            .font(.title.bold())
            .lineLimit(1)
    }

    public init(store: StoreOf<Quiz>) {
        self.store = store
    }
}

struct MinimumScaleModifier: ViewModifier {
    let scaleFactor: CGFloat

    func body(content: Content) -> some View {
        content
            .minimumScaleFactor(scaleFactor)
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

extension View {
    func minimumScale(_ scaleFactor: CGFloat) -> some View {
        modifier(MinimumScaleModifier(scaleFactor: scaleFactor))
    }
}
