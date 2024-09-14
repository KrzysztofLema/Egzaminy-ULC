import Foundation

enum CoreDataError: Error {
    case saveError(NSError)
    case fetchError(NSError)
    case invalidObject
    case questionNotFound

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
        }
    }
}
