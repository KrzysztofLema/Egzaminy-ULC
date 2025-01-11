import Foundation

public enum LocalizationProvider {
    public enum SettingsResetAlert {
        public static var cannotReversedInfo: String {
            String(localized: "cannotReversedInfo")
        }

        public static var cancelResetProgress: String {
            String(localized: "cancelResetProgress")
        }

        public static var resetAreYouSure: String {
            String(localized: "resetAreYouSure")
        }

        public static var resetProgress: String {
            String(localized: "resetProgress")
        }
    }

    public enum Settings {
        public static var appearance: String {
            String(localized: "appearance")
        }

        public static var appVersion: String {
            String(localized: "appVersion")
        }

        public static var chooseSubjectAgain: String {
            String(localized: "chooseSubjectAgain")
        }

        public static var startOver: String {
            String(localized: "startOver")
        }
    }

    public enum Quiz {
        public static var nextQuestion: String {
            String(localized: "nextQuestion")
        }
    }

    public enum ExamDetails {
        public static var selectSubject: String {
            String(localized: "selectSubject")
        }
    }

    public enum MainMenu {
        public static var favoritesQuestions: String {
            String(localized: "favoritesQuestions")
        }

        public static var quiz: String {
            String(localized: "quiz")
        }
    }

    public enum Onboarding {
        public static var applicationTitle: String {
            String(localized: "applicationTitle")
        }

        public static var civilAviationAuthority: String {
            String(localized: "civilAviationAuthority")
        }

        public static var chooseExam: String {
            String(localized: "chooseExam")
        }

        public static var nextOnboardingButton: String {
            String(localized: "nextOnboardingButton")
        }

        public static var withUsYouWillPass: String {
            String(localized: "withUsYouWillPassWelcome")
        }

        public static var welcomeToApp: String {
            String(localized: "welcomeToApp")
        }
    }

    public enum Tab {
        public static var homeTab: String {
            String(localized: "homeTab")
        }

        public static var settingsTab: String {
            String(localized: "settingsTab")
        }
    }

    public enum Error {
        public static var fullScreenTitle: String {
            String(localized: "errorTitle")
        }

        public static var fullScreenDescription: String {
            String(localized: "errorDescription")
        }
    }

    public enum Loading {
        public static var fullScreenLoadingTitle: String {
            String(localized: "loadingTitle")
        }

        public static var fullScreenLoadingDescription: String {
            String(localized: "loadingDescription")
        }
    }
}
