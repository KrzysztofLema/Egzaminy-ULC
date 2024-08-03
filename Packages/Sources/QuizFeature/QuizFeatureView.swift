import SharedModels
import SharedViews
import SwiftUI

public struct QuizFeatureView: View {
    @ObserveInjection private var iO
    @Binding var show: Bool
    @State var isBookmarkSelected = false
    @State var presentedQuestion = 0
    
    var subject: Subject

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
                QuestionView(question: subject.questions[presentedQuestion])
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).fill(.ultraThinMaterial)
            )

            Spacer()

            Button(action: {
                presentedQuestion += 1
                
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
            show = false
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

    public init(show: Binding<Bool>, subject: Subject) {
        _show = show
        self.subject = subject
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
