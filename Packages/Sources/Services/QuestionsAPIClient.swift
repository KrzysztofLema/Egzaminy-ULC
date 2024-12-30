import Dependencies
import Foundation
import SharedModels

public struct QuestionsAPIClient {
    public var fetchQuestions: @Sendable (_ identifier: String) async throws -> [Question]
}

extension QuestionsAPIClient: DependencyKey {
    public static var liveValue: QuestionsAPIClient {
        Self { identifier in
            let requestManager = RequestManager()

            do {
                let questions: [QuestionDto] = try await requestManager.perform(QuestionsRequest.getQuestionsWithAnwsersBy(identifier: identifier))
                return questions.enumerated().map { index, questionDTO in Question(order: index, dto: questionDTO) }
            } catch {
                throw NetworkError.invalidServerResponse
            }
        }
    }
}

extension QuestionsAPIClient: TestDependencyKey {
    public static let testValue = Self { _ in [] }
}

extension DependencyValues {
    public var questionsAPIClient: QuestionsAPIClient {
        get { self[QuestionsAPIClient.self] }
        set { self[QuestionsAPIClient.self] = newValue }
    }
}
