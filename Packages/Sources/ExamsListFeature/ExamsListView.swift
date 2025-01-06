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
        ZStack {
            switch (store.isLoading, store.errorOccured, store.exams) {
            case (true,_,_):
                fullScreenLoaderView
            case (false, true, _):
                fullScreenErrorView
            case (false, false, let exams):
                examsList(exams: exams)
            }
        }
        .task {
            await store.send(.task).finish()
        }
        .navigationBarBackButtonHidden()
    }

    private func examsList(exams: IdentifiedArrayOf<Exam>) -> some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(exams) { exam in
                        Button(action: {
                            store.send(.examDetailButtonTapped(exam))
                        }, label: {
                            ExamView(exam: exam)
                        })
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var fullScreenErrorView: some View {
        FullScreenErrorView {
            store.send(.closeButtonTapped)
        }
    }
    
    private var fullScreenLoaderView: some View {
        FullScreenLoaderView {
            store.send(.closeButtonTapped)
        }
    }
}
