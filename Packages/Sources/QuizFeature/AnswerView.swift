import ComposableArchitecture
import Inject
import SharedModels
import SwiftUI

@Reducer
public struct AnswerFeature {
    @ObservableState
    public struct State: Equatable, Identifiable {
        public let id: UUID
        var answer: Answer
        var isSelected: Bool = false

        public init(id: UUID, answer: Answer) {
            self.id = id
            self.answer = answer
        }
    }

    public enum Action: ViewAction, Equatable {
        public enum Delegate: Equatable {
            case didSelectionChanged(AnswerFeature.State)
        }

        public enum View: Equatable {
            case onAnswerButtonTapped
        }

        case view(View)
        case delegate(Delegate)
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.onAnswerButtonTapped):
                return .send(.delegate(.didSelectionChanged(state)))
            case .delegate:
                return .none
            }
        }
    }
}

@ViewAction(for: AnswerFeature.self)
struct AnswerView: View {
    var store: StoreOf<AnswerFeature>

    var body: some View {
        Text(store.answer.answerTitle ?? "")
            .font(.subheadline)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(5)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(content: {
                store.isSelected ? Color(.blue) : Color.black.opacity(0.1)
            })
            .cornerRadius(10)
            .onTapGesture {
                send(.onAnswerButtonTapped)
            }
    }
}

public enum AnswerType {
    case selected
    case notSelected
    case correct
    case notCorrect
}
