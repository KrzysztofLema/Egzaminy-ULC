public protocol EmptyElement {
    static var empty: Self { get }
}

extension String: EmptyElement {
    public static var empty: Self { .init() }
}
