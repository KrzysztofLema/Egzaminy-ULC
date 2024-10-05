import ComposableArchitecture
import CoreUI
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
        VStack {
            ForEach(store.exams) { exam in
                Button(action: {
                    store.send(.examDetailButtonTapped(exam), animation: .default)
                }, label: {
                    ExamView(exam: exam)
                })
            }
        }
    }
}
