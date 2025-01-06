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
        Group {
            switch store.examsListViewState {
            case let .success(exams: exams):
                examsList(exams: exams)
            case .failure:
                fullScreenErrorView
            case .inProgress:
                ProgressView()
            case .initial:
                EmptyView()
            }
        }.onAppear {
            store.send(.onViewDidLoad)
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
}
