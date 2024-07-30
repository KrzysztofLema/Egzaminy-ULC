import Foundation

public struct Subject: Identifiable {
    public let id = UUID()
    public let title: String
    public let image: String
    public let questions: [String]
}

var subjects = [
    Subject(title: "Człowiek: Możliwości i Ograniczenia", image: "figure.walk.motion.trianglebadge.exclamationmark", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Meteorologia", image: "cloud.sun.rain", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Nawigacja", image: "compass.drawing", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Ogólna Wiedza o Statku Powietrznym", image: "airplane", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Osiągi i Planowanie Lotu", image: "airplane.departure", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Prawo Lotnicze", image: "checkmark.gobackward", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Procedury Operacyjne", image: "fuelpump.fill", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Zasady Lotu", image: "airplane", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
    Subject(title: "Łączność", image: "mic", questions: ["Pytanie 1, Pytanie 2, Pytanie 3, Pytanie 4"]),
]
