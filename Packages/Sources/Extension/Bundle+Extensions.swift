import Foundation

extension Bundle {
    public func string(for key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
}
