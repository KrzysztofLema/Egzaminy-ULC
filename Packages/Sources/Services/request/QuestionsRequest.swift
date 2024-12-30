enum QuestionsRequest: RequestProtocol {
    case getQuestionsWithAnwsersBy(identifier: String?)

    var path: String {
        switch self {
        case .getQuestionsWithAnwsersBy: "/api/questions"
        }
    }

    var urlParams: [String: String?] {
        switch self {
        case let .getQuestionsWithAnwsersBy(identifier: identifier):
            var params: [String: String] = [:]
            if let identifier {
                params["subjectID"] = identifier
            }
            return params
        }
    }

    var requestType: RequestType {
        .GET
    }
}
