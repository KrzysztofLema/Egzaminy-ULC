import ComposableArchitecture
import CoreDataClient
@testable import QuizFeature
import SharedModels
import XCTest

final class QuizTests: XCTestCase {
    func testOnViewLoad() async {
        let subjectMock = Subject.mock

        let store = await TestStore(
            initialState: Quiz.State(
                id: UUID(),
                subject: subjectMock
            )
        ) {
            Quiz()
        } withDependencies: {
            $0.uuid = .incrementing
            $0.coreData.fetchQuestion = { _, _ in .mock }
        }

        await store.withExhaustivity(.off) {
            await store.send(.view(.onViewLoad))

            await store.receive(\.updateCurrentQuestion.success) {
                $0.currentQuestion = .mock
                $0.alert = nil
                $0.selectedAnswer = nil
                $0.isNextButtonEnabled = false
            }
        }
    }

    func testOnViewLoad_withFailureFetch() async {
        let subjectMock = Subject.mock
        let dismissed = LockIsolated(false)

        let store = await TestStore(
            initialState: Quiz.State(
                id: UUID(),
                subject: subjectMock
            )
        ) {
            Quiz()
        } withDependencies: {
            $0.uuid = .incrementing
            $0.dismiss = .init { dismissed.setValue(true) }
        }

        await store.withExhaustivity(.off) {
            await store.send(.view(.onViewLoad))

            await store.send(.updateCurrentQuestion(.failure(CoreDataError.fetchError(NSError()))))

            XCTAssert(dismissed.value)
        }
    }

    func testNextQuestionButtonTapped_withSuccessFetch_shouldUpdateQuestionsAndAnswers() async {
        let subjectMock = Subject.mock

        let store = await TestStore(
            initialState: Quiz.State(
                id: UUID(0),
                subject: subjectMock,
                alert: AlertState(title: {
                    TextState("Odpowiedź jest poprawna!")
                })
            )
        ) {
            Quiz()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        await store.withExhaustivity(.off) {
            await store.send(.alert(.presented(.confirmCorrect)))
            await store.receive {
                guard case .updateCurrentQuestion(.success(.mock)) = $0 else {
                    return false
                }
                return true
            } assert: {
                $0.currentQuestion = .mock
                $0.selectedAnswer = nil
                let answers = Question.mock.answers?.enumerated().map { index, answer in
                    AnswerFeature.State(
                        id: UUID(index),
                        answer: answer
                    )
                } ?? []

                $0.answers = IdentifiedArray(uniqueElements: answers)
                $0.isNextButtonEnabled = false
            }
        }
    }
}
