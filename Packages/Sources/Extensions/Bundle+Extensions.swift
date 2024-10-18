import Foundation

extension Bundle {
    public func string(for key: String) -> String {
        guard let object = object(forInfoDictionaryKey: key) as? String else {
            return ""
        }

        return object
    }
}
