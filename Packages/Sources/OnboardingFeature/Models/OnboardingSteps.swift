public enum OnboardingSteps: Int, CaseIterable {
    case welcome
    case welcome2
    case choseSubject

    mutating func next() {
        let allCases = OnboardingSteps.allCases
        if let currentIndex = allCases.firstIndex(of: self),
           currentIndex + 1 < allCases.count {
            self = allCases[currentIndex + 1]
        }
    }

    func isLast() -> Bool {
        self == OnboardingSteps.allCases.last
    }
}
