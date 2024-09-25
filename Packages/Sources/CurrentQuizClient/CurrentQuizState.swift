import ComposableArchitecture
import SharedModels

public struct CurrentQuizState: Codable, Equatable {
    public var currentProgress: [Subject.ID: Int] = [:]
}

extension PersistenceKey where Self == PersistenceKeyDefault<FileStorageKey<CurrentQuizState>> {
    public static var currentQuizState: Self {
        PersistenceKeyDefault(.fileStorage(.documentsDirectory.appending(path: "current-quiz-state.json")), CurrentQuizState())
    }
}
