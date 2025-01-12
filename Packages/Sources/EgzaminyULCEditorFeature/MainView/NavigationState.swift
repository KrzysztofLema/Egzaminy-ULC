import SharedModels
import SwiftUI

public enum Router: Hashable {
    case empty
    case subjects(Exam)
    case questionDetail(SharedModels.Subject)
}

@Observable
final class SceneState {
    var mainSelection: Router = .empty
    var navigationStack: [Router] = []

    var detailSelection: Router = .empty
}

extension Router {
    struct DestinationView: View {
        let router: Router
        @Environment(SceneState.self) private var scene

        var body: some View {
            switch router {
            case .empty:
                EmptyView()
            case let .questionDetail(subject):
                QuestionSplitView(subject: subject)
            case let .subjects(exam):
                SubjectDetailView(exam: exam)
            }
        }
    }
}
