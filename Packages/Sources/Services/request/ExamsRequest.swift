enum ExamsRequest: RequestProtocol {
    case getExamsAllData
    case getExams
    case getExamBy(identifier: String?)

    var path: String {
        switch self {
        case .getExamsAllData: "/api/exams/all/data"
        case .getExams: "/api/exams/all"
        default: "/api/exams"
        }
    }

    var urlParams: [String: String?] {
        switch self {
        case .getExamsAllData:
            return [:]
        case .getExams:
            return [:]
        case let .getExamBy(identifier: identifier):
            var params: [String: String] = [:]
            if let identifier {
                params["examID"] = identifier
            }
            return params
        }
    }

    var requestType: RequestType {
        .GET
    }
}
