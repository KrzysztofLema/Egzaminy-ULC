import ComposableArchitecture
import CoreUI
import QuizFeature
import SharedModels
import SharedViews
import SwiftUI

@ViewAction(for: ExamDetail.self)
public struct ExamDetailView: View {
    @ObserveInjection private var iO

    public var store: StoreOf<ExamDetail>

    public var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack {
                    Image(store.exam.image ?? "")
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 20)
                        .cornerRadius(30.0)
                        .overlay {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.black.opacity(0.2))
                        }
                        .strokeStyle(cornerRadius: 30)

                    Text("Wybierz przedmiot:".uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)

                    ForEachStore(store.scope(state: \.subjects, action: \.subjects)) { store in
                        SubjectView(store: store)
                            .onTapGesture {
                                send(.presentQuizSubjectButtonTapped(store.subject))
                            }
                    }
                }
            }
        }
        .onAppear(perform: {
            send(.onViewAppear)
        })
        .tabViewStyle(.automatic)
        .fullScreenCover(store: store.scope(state: \.$destination.presentQuiz, action: \.destination.presentQuiz), content: { store in
            QuizView(store: store)
        })
        .alert(store: store.scope(state: \.$alert, action: \.alert))
        .enableInjection()
    }

    public init(store: StoreOf<ExamDetail>) {
        self.store = store
    }
}
