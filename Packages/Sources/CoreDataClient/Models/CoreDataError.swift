import Foundation

public enum CoreDataError: Error, Equatable {
    case saveError(NSError)
    case fetchError(NSError)
    case invalidObject
    case questionNotFound
    case subjectNotFound

    var localizedDescription: String {
        switch self {
        case let .saveError(error):
            return "Failed to save data: \(error.localizedDescription)"
        case let .fetchError(error):
            return "Failed to fetch data: \(error.localizedDescription)"
        case .invalidObject:
            return "Invalid object encountered."
        case .questionNotFound:
            return "The question with specific ID was not found"
        case .subjectNotFound:
            return "The subject with specific ID was not found"
        }
    }
}
