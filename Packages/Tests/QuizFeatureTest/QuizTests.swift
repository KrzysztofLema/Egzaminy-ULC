import ComposableArchitecture
@testable import QuizFeature
import SharedModels
import XCTest

@MainActor
final class QuizTests: XCTestCase {
    func testSelectAnswer() async {
        let subjectMock = Subject.mock
        let dismissed = LockIsolated(false)

        let store = TestStore(initialState: Quiz.State(id: UUID(), subject: subjectMock)) {
            Quiz()
        } withDependencies: {
            $0.uuid = .incrementing
            $0.dismiss = .init { dismissed.setValue(true) }
            $0.coreData.fetchQuestion = { _, _ in .mock }
        }

        await store.send(.view(.onViewLoad)) {
            $0.alert = nil
            $0.isNextButtonEnabled = false
            $0.currentQuestion = .mock
            $0.answers = .init(
                uniqueElements: store.state.currentQuestion?.answers?.enumerated().map {
                    AnswerFeature.State(
                        id: UUID($0.offset),
                        answer: $0.element
                    )
                } ?? []
            )
        }

        await store.send(.nextQuestion) {
            $0.alert = .nextQuestion(isAnswerCorrect: false)
            $0.subject.currentProgress = 0
            $0.selectedAnswer = nil
        }

        await store.send(.selectedAnswer(.view(.onAnswerButtonTapped)))

        await store.send(.view(.closeQuizButtonTapped))

        XCTAssert(dismissed.value)
    }
}
