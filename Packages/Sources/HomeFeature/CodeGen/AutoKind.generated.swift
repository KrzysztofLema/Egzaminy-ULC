// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// MARK: - AutoKind conformances

extension Filter {
    enum Kind: String, RawRepresentable, CaseIterable, Identifiable {
        case contains
        case prefix
        case suffix

        var id: String { rawValue }
    }
    var kind: Kind {
        switch self {
        case .contains: .contains
        case .prefix: .prefix
        case .suffix: .suffix
        }
    }
}
