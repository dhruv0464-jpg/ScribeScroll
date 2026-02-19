import SwiftUI
import Combine

class ReadingManager: ObservableObject {
    @Published var completedPassageIDs: Set<Int> = []
    @Published var totalReadings: Int {
        didSet { UserDefaults.standard.set(totalReadings, forKey: "totalReadings") }
    }
    @Published var totalMinutesRead: Int {
        didSet { UserDefaults.standard.set(totalMinutesRead, forKey: "totalMinutesRead") }
    }
    @Published var streak: Int {
        didSet { UserDefaults.standard.set(streak, forKey: "streak") }
    }
    @Published var quizAccuracy: Double {
        didSet { UserDefaults.standard.set(quizAccuracy, forKey: "quizAccuracy") }
    }
    @Published var totalCorrect: Int {
        didSet { UserDefaults.standard.set(totalCorrect, forKey: "totalCorrect") }
    }
    @Published var totalQuestions: Int {
        didSet { UserDefaults.standard.set(totalQuestions, forKey: "totalQuestions") }
    }
    
    @Published var weeklyStats: [DayStat] = [
        DayStat(dayLabel: "M", readings: 3, minutes: 12),
        DayStat(dayLabel: "T", readings: 2, minutes: 8),
        DayStat(dayLabel: "W", readings: 4, minutes: 18),
        DayStat(dayLabel: "T", readings: 1, minutes: 4),
        DayStat(dayLabel: "F", readings: 3, minutes: 14),
        DayStat(dayLabel: "S", readings: 5, minutes: 22),
        DayStat(dayLabel: "S", readings: 2, minutes: 9),
    ]
    
    @Published var blockedApps: [BlockedApp] = [
        BlockedApp(id: "instagram", name: "Instagram", icon: "camera.fill", color: Color(hex: "E1306C"), dailyLimitMinutes: 45, usedMinutes: 32),
        BlockedApp(id: "tiktok", name: "TikTok", icon: "music.note", color: Color(hex: "000000"), dailyLimitMinutes: 30, usedMinutes: 30),
        BlockedApp(id: "twitter", name: "Twitter / X", icon: "at", color: Color(hex: "1DA1F2"), dailyLimitMinutes: 20, usedMinutes: 8),
        BlockedApp(id: "youtube", name: "YouTube", icon: "play.rectangle.fill", color: Color(hex: "FF0000"), dailyLimitMinutes: 60, usedMinutes: 44),
        BlockedApp(id: "snapchat", name: "Snapchat", icon: "camera.viewfinder", color: Color(hex: "FFFC00"), dailyLimitMinutes: 15, usedMinutes: 2),
        BlockedApp(id: "reddit", name: "Reddit", icon: "bubble.left.fill", color: Color(hex: "FF4500"), dailyLimitMinutes: 20, usedMinutes: 18),
    ]
    
    @Published var enabledAppIDs: Set<String> = ["instagram", "tiktok", "youtube"]
    
    var enabledApps: [BlockedApp] {
        blockedApps.filter { enabledAppIDs.contains($0.id) }
    }
    
    var lockedCount: Int {
        enabledApps.filter(\.isLocked).count
    }
    
    var categoriesRead: Int {
        Set(completedPassageIDs.compactMap { id in
            PassageLibrary.all.first(where: { $0.id == id })?.category
        }).count
    }
    
    var weeklyTotalMinutes: Int {
        weeklyStats.reduce(0) { $0 + $1.minutes }
    }
    
    var maxWeeklyMinutes: Int {
        weeklyStats.map(\.minutes).max() ?? 1
    }
    
    init() {
        let storedReadings = UserDefaults.standard.integer(forKey: "totalReadings")
        let storedMinutes = UserDefaults.standard.integer(forKey: "totalMinutesRead")
        let storedStreak = max(UserDefaults.standard.integer(forKey: "streak"), 7)
        let storedCorrect = UserDefaults.standard.integer(forKey: "totalCorrect")
        let storedQuestions = UserDefaults.standard.integer(forKey: "totalQuestions")

        self.totalReadings = storedReadings
        self.totalMinutesRead = storedMinutes
        self.streak = storedStreak
        self.totalCorrect = storedCorrect
        self.totalQuestions = storedQuestions
        self.quizAccuracy = storedQuestions > 0 ? Double(storedCorrect) / Double(storedQuestions) : 0.82
        
        if totalReadings == 0 { totalReadings = 20 }
        if totalMinutesRead == 0 { totalMinutesRead = 87 }
    }
    
    func recordQuizResult(passage: Passage, correct: Int, total: Int) {
        totalCorrect += correct
        totalQuestions += total
        quizAccuracy = Double(totalCorrect) / Double(max(1, totalQuestions))
        
        if correct >= 2 {
            completedPassageIDs.insert(passage.id)
            totalReadings += 1
            totalMinutesRead += passage.readTimeMinutes
            streak += 0 // streak managed by date logic in production
        }
    }

    func grantUnlock(for appID: String, bonusMinutes: Int = 15) {
        guard let index = blockedApps.firstIndex(where: { $0.id == appID }) else { return }
        blockedApps[index].usedMinutes = max(0, blockedApps[index].usedMinutes - bonusMinutes)
    }
    
    func toggleApp(_ id: String) {
        if enabledAppIDs.contains(id) {
            enabledAppIDs.remove(id)
        } else {
            enabledAppIDs.insert(id)
        }
    }
    
    func isAppEnabled(_ id: String) -> Bool {
        enabledAppIDs.contains(id)
    }
    
    func nextUnreadPassage() -> Passage? {
        PassageLibrary.all.first { !completedPassageIDs.contains($0.id) }
    }
    
    func passages(for category: PassageCategory?) -> [Passage] {
        guard let category else { return PassageLibrary.all }
        return PassageLibrary.all.filter { $0.category == category }
    }
}
