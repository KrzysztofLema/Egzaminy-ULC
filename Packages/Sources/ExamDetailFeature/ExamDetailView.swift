import ComposableArchitecture
import CoreUI
import Providers
import QuizFeature
import SharedModels

@ViewAction(for: ExamDetail.self)
public struct ExamDetailView: View {
    @ObserveInjection private var iO

    public var store: StoreOf<ExamDetail>

    public var body: some View {
        Group {
            switch (store.isLoading, store.isErrorOccurred, store.exam) {
            case (true, false, _):
                ProgressView()
            case (false, true, _):
                FullScreenErrorView()
            case let (_, _, exam):
                ZStack {
                    Color.primaryBackground.ignoresSafeArea()

                    ScrollView(showsIndicators: false) {
                        VStack {
                            StretchyHeaderView {
                                Image(exam?.image ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }

                            Text("\(LocalizationProvider.ExamDetails.selectSubject):".uppercased())
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
            }
        }
        .coordinateSpace(name: "ExamDetails.ScrollView")
        .navigationTitle(store.exam?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            send(.onViewAppear)
        })
        .tabViewStyle(.automatic)
        .fullScreenCover(
            store: store.scope(
                state: \.$destination.presentQuiz,
                action: \.destination.presentQuiz
            ),
            content: { store in
                QuizView(store: store)
            }
        )
        .alert(store: store.scope(state: \.$alert, action: \.alert))
        .enableInjection()
    }

    public init(store: StoreOf<ExamDetail>) {
        self.store = store
    }
}
