import ComposableArchitecture
import SharedModels
import SharedViews
import SwiftUI

@Reducer
public struct SubjectFeature {
    @ObservableState
    public struct State: Identifiable, Equatable {
        public let id: UUID
        var subject: Subject

        public init(id: UUID, subject: Subject) {
            self.id = id
            self.subject = subject
        }
    }

    public enum Action: Equatable {
        case updateProgress(Int)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .updateProgress(currentProgress):
                state.subject.currentProgress = currentProgress
                return .none
            }
        }
    }

    public init() {}
}

struct SubjectView: View {
    @ObserveInjection private var iO

    @Bindable var store: StoreOf<SubjectFeature>

    var body: some View {
        HStack {
            Image(systemName: store.subject.image ?? "")
                .resizable()
                .foregroundColor(.primary)
                .frame(width: 32.0, height: 32.0)
                .padding(5)

            VStack(alignment: .leading, spacing: 12) {
                Text(store.subject.title ?? "")
                    .foregroundColor(.primary)
                    .font(.headline)

                HStack {
                    Text("\(store.subject.currentProgress ?? 0)")
                    ProgressView(value: Double(store.subject.currentProgress ?? 0), total: .init(store.subject.questions?.count ?? 0))
                    Text("\(store.subject.questions?.count ?? 0)")
                }
                .foregroundColor(.secondary)
                .font(.footnote)
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            Rectangle().fill(.ultraThinMaterial).mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )

        .enableInjection()
    }
}
