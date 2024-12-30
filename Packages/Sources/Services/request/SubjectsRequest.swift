import Foundation

enum SubjectsRequest: RequestProtocol {
    case getSubjectBy(identifier: String)

    var path: String {
        "/api/subjects"
    }

    var urlParams: [String: String?] {
        switch self {
        case let .getSubjectBy(identifier):
            let params = ["examID": identifier]
            return params
        }
    }

    var requestType: RequestType {
        .GET
    }
}
