enum ExamsRequest: RequestProtocol {
    case getExams

    var path: String {
        "/api/exams"
    }

    var urlParams: [String: String?] {
        switch self {
        case .getExams:
            return [:]
        }
    }

    var requestType: RequestType {
        .GET
    }
}
