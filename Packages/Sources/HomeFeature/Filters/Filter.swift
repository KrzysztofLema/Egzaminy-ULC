import Foundation

enum Filter: AutoKind {
    case contains(String)
    case prefix(String)
    case suffix(String)
}
