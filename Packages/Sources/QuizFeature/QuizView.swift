import ComposableArchitecture
import SharedModels
import SharedViews
import SwiftUI

public struct QuizView: View {
    @ObserveInjection private var iO
    @Bindable var store: StoreOf<Quiz>

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
                QuestionView(question: store.subject.questions[store.presentedQuestion])
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial)
            )

            Spacer()

            Button(action: {
                store.send(.nextQuestionButtonTapped)
            }, label: {
                Text("Następne")
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)

        .enableInjection()
    }

    var closeButton: some View {
        Button {
            store.send(.closeQuizButtonTapped)
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
