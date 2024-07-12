import Foundation

struct Item: Equatable {
    struct Dimmensions: Equatable {
        var width: Double
        var height: Double
        var depth: Double
    }

    let id: UUID
    var name: String
    var category: String
    var quantity: Int
    var price: Double
    var dateAdded: Date
    var isInStock: Bool
    var description: String
    var tags: [String]
    var dimensions: Dimmensions
}

// Helper function to generate random strings for names, categories, and tags
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return String((0..<length).map { _ in letters.randomElement()! })
}

// Helper function to generate random tags array
func randomTags() -> [String] {
    (1...Int.random(in: 1...5)).map { _ in randomString(length: Int.random(in: 3...10)) }
}

func randomDate() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    return dateFormatter.date(from: "\(Int.random(in: 1970...2023))/\(Int.random(in: 1...12))/\(Int.random(in: 1...28))") ?? Date()
}

extension Item {
    static func random(id: UUID) -> Item {
        .init(
            id: id,
            name: randomString(length: Int.random(in: 5...10)),
            category: randomString(length: Int.random(in: 5...10)),
            quantity: Int.random(in: 1...100),
            price: Double.random(in: 10.0...1000.0),
            dateAdded: randomDate(),
            isInStock: Bool.random(),
            description: randomString(length: Int.random(in: 20...100)),
            tags: randomTags(),
            dimensions: .init(
                width: Double.random(in: 0.5...5.0),
                height: Double.random(in: 0.5...5.0),
                depth: Double.random(in: 0.5...5.0)
            )
        )
    }
}
