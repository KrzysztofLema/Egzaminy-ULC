import ComposableArchitecture
import ExamDetailFeature
import SharedModels
import SharedViews
import SwiftUI

public struct ExamsListView: View {
    @ObserveInjection private var iO
    @Bindable var store: StoreOf<ExamsList>

    public init(store: StoreOf<ExamsList>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(store.exams) { exam in
                        Button(action: {
                            store.send(.examDetailButtonTapped(exam))
                        }, label: {
                            ExamView(exam: exam)
                        })
                    }
                }
            }
        } destination: { store in
            switch store.case {
            case let .examDetailView(store):
                ExamDetailView(store: store)
            }
        }
    }
}
