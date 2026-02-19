import SwiftUI
import Combine

enum AppScreen: Equatable {
    case splash
    case onboarding
    case paywall
    case main
    case reading(Passage)
    case quiz(Passage)
    case results(score: Int, total: Int, passage: Passage)
    case blockedOverlay(BlockedApp)
    
    static func == (lhs: AppScreen, rhs: AppScreen) -> Bool {
        switch (lhs, rhs) {
        case (.splash, .splash), (.onboarding, .onboarding),
             (.paywall, .paywall), (.main, .main):
            return true
        case let (.reading(a), .reading(b)):
            return a.id == b.id
        case let (.quiz(a), .quiz(b)):
            return a.id == b.id
        case let (.results(s1, t1, p1), .results(s2, t2, p2)):
            return s1 == s2 && t1 == t2 && p1.id == p2.id
        case let (.blockedOverlay(a), .blockedOverlay(b)):
            return a.id == b.id
        default:
            return false
        }
    }
}

enum PaywallEntryPoint {
    case onboarding
    case unlockLimitReached
    case premiumFeature
    case settings
}

enum MainTab: String, CaseIterable {
    case home = "Home"
    case library = "Library"
    case stats = "Stats"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .library: return "books.vertical.fill"
        case .stats: return "chart.bar.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

class AppState: ObservableObject {
    static let dailyFreeUnlockLimit = 3

    @Published var currentScreen: AppScreen = .splash
    @Published var selectedTab: MainTab = .home
    @Published var onboardingStep: Int = 0
    @Published var selectedPlan: SubscriptionPlan = .yearly
    @Published var paywallEntryPoint: PaywallEntryPoint = .onboarding
    @Published var pendingUnlockAppID: String?
    @Published private var quizUnlockedPassageIDs: Set<Int> = []
    
    // User preferences persisted
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("isPremiumUser") var isPremiumUser = false
    @AppStorage("userName") var userName = ""
    @AppStorage("dailyGoal") var dailyGoal = 3
    @AppStorage("difficultyLevel") var difficultyLevel = "Medium"
    @AppStorage("strictMode") var strictMode = false
    @AppStorage("notificationsEnabled") var notificationsEnabled = true
    @AppStorage("hapticsEnabled") var hapticsEnabled = true
    @AppStorage("freeUnlockCreditsRemaining") var freeUnlockCreditsRemaining = AppState.dailyFreeUnlockLimit
    @AppStorage("lastUnlockCreditResetAt") private var lastUnlockCreditResetAt: Double = 0

    init() {
        refreshDailyUnlockCreditsIfNeeded()
    }
    
    func navigate(to screen: AppScreen) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = screen
        }
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        if isPremiumUser {
            goHome()
        } else {
            presentPaywall(from: .onboarding)
        }
    }
    
    func goHome() {
        navigate(to: .main)
        selectedTab = .home
        pendingUnlockAppID = nil
    }

    func presentPaywall(from entryPoint: PaywallEntryPoint) {
        paywallEntryPoint = entryPoint
        navigate(to: .paywall)
    }

    func splashDidFinish() {
        refreshDailyUnlockCreditsIfNeeded()
        if hasCompletedOnboarding {
            navigate(to: .main)
        } else {
            navigate(to: .onboarding)
        }
    }

    var canUnlockBlockedApps: Bool {
        isPremiumUser || freeUnlockCreditsRemaining > 0
    }

    func markPassageReadyForQuiz(_ passageID: Int) {
        quizUnlockedPassageIDs.insert(passageID)
    }

    func canTakeQuiz(for passage: Passage) -> Bool {
        quizUnlockedPassageIDs.contains(passage.id)
    }

    @discardableResult
    func consumeUnlockCreditIfNeeded() -> Bool {
        refreshDailyUnlockCreditsIfNeeded()
        guard !isPremiumUser else { return true }
        guard freeUnlockCreditsRemaining > 0 else {
            return false
        }

        freeUnlockCreditsRemaining -= 1
        return true
    }

    func refreshDailyUnlockCreditsIfNeeded(referenceDate: Date = Date()) {
        guard !isPremiumUser else {
            freeUnlockCreditsRemaining = AppState.dailyFreeUnlockLimit
            lastUnlockCreditResetAt = referenceDate.timeIntervalSince1970
            return
        }

        let calendar = Calendar.current
        let lastResetDate = Date(timeIntervalSince1970: lastUnlockCreditResetAt)

        if lastUnlockCreditResetAt == 0 || !calendar.isDate(lastResetDate, inSameDayAs: referenceDate) {
            freeUnlockCreditsRemaining = AppState.dailyFreeUnlockLimit
            lastUnlockCreditResetAt = referenceDate.timeIntervalSince1970
        }
    }
}

enum SubscriptionPlan: String, CaseIterable {
    case weekly = "Weekly"
    case yearly = "Annual"
    case monthly = "Monthly"
    
    var price: String {
        switch self {
        case .weekly: return "$2.99"
        case .yearly: return "$29.99"
        case .monthly: return "$6.99"
        }
    }
    
    var period: String {
        switch self {
        case .weekly: return "/week"
        case .yearly: return "/year"
        case .monthly: return "/month"
        }
    }
    
    var savings: String? {
        switch self {
        case .yearly: return "75% OFF"
        default: return nil
        }
    }
    
    var trial: String? {
        switch self {
        case .yearly: return "7-day free trial"
        default: return nil
        }
    }
}
