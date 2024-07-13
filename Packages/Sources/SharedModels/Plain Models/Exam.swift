import Foundation

public struct Exam: Identifiable {
    public let id = UUID()
    public var title: String
    public var subtitle: String
    public var text: String
    public var image: String
    public var background: String
    public var logo: String
}

public var exams = [
    Exam(
        title: "PPL(A)",
        subtitle: "Licencja Pilota Turystycznego Samolotowego PPL(A)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd lotnictwa cywilnego do licencji Turystycznej Samolotowej PPL(A).",
        image: "cessna-c172",
        background: "PPL(A)-Background",
        logo: "logo-1"
    ),
    Exam(
        title: "PPL(H) EN",
        subtitle: "Licencja Pilota Turystycznego Samolotowego PPL(H)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd Lotnictwa Cywilnego do Licencji Turystycznej na Helikopter PPL(H) w wersji Angielskiej.",
        image: "helicopter",
        background: "PPL(H)-Background",
        logo: "logo-2"
    ),
    Exam(
        title: "PPL(G)",
        subtitle: "Licencja Pilota Turystycznego Szybowcowego PPL(G)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd Lotnictwa Cywilnego do Licencji Turystycznej Szybowcowej PPL(G).",
        image: "glider",
        background: "",
        logo: ""
    ),
    Exam(
        title: "PPL(B)",
        subtitle: "Licencja Pilota Balonu PPL(B)",
        text: "Przykładowe pytania egzaminacyjne opublikowane przez Urząd Lotnictwa Cywilnego do Licencji Turystycznej Balonowej PPL(B).",
        image: "ballon",
        background: "",
        logo: ""
    ),
    Exam(
        title: "PPL(A) EN",
        subtitle: "Licencja Pilota Turystycznego Samolotowego PPL(A) EN",
        text: "Przykładowe pytania egzaminacyjne opublikowane prez Urząd Lotnictwa Cywilnego dla Licencji Turystycznej Samolotowej PPL(A) w wersji Angielskiej.",
        image: "cessna-2",
        background: "",
        logo: ""
    ),
]
