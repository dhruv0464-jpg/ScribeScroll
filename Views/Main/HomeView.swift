import SwiftUI

// MARK: - Main Tab View

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(MainTab.home)

            FreeReadView()
                .tabItem {
                    Image(systemName: "text.quote")
                    Text("Free Read")
                }
                .tag(MainTab.freeRead)
            
            LibraryView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
                .tag(MainTab.library)
            
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(MainTab.stats)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(MainTab.settings)
        }
        .tint(DS.accent)
    }
}

struct FreeReadFeedItem {
    let passage: Passage
    let excerpt: String
    let segmentIndex: Int
    let totalSegments: Int

    var stableID: String { "\(passage.id)-\(segmentIndex)" }

    var baseLikeCount: Int {
        120 + ((passage.id * 89 + segmentIndex * 41) % 9200)
    }

    var shareText: String {
        "\"\(excerpt)\"\n\nFrom: \(passage.title) • \(passage.category.rawValue)\nShared from Readtounlock"
    }

    static let seedPool: [FreeReadFeedItem] = buildSeedPool()

    private static func buildSeedPool() -> [FreeReadFeedItem] {
        let normalized: [(Passage, [String])] = PassageLibrary.all.map { passage in
            let segments = splitIntoSegments(passage.content)
            return (passage, segments.isEmpty ? [passage.content.trimmingCharacters(in: .whitespacesAndNewlines)] : segments)
        }

        let maxSegments = normalized.map { $0.1.count }.max() ?? 0
        var pool: [FreeReadFeedItem] = []

        for segmentOffset in 0..<maxSegments {
            for (passage, segments) in normalized {
                guard segmentOffset < segments.count else { continue }
                pool.append(
                    FreeReadFeedItem(
                        passage: passage,
                        excerpt: segments[segmentOffset],
                        segmentIndex: segmentOffset + 1,
                        totalSegments: segments.count
                    )
                )
            }
        }

        return pool
    }

    // Build longer reel cards: each item is a coherent multi-paragraph chunk.
    private static func splitIntoSegments(_ content: String) -> [String] {
        let paragraphs = content
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.count > 40 }

        guard !paragraphs.isEmpty else { return [] }

        let targetChars = 950
        var segments: [String] = []
        var current: [String] = []
        var currentCount = 0

        for paragraph in paragraphs {
            let nextCount = currentCount + paragraph.count + (current.isEmpty ? 0 : 2)
            if !current.isEmpty && nextCount > targetChars {
                segments.append(current.joined(separator: "\n\n"))
                current = [paragraph]
                currentCount = paragraph.count
            } else {
                current.append(paragraph)
                currentCount = nextCount
            }
        }

        if !current.isEmpty {
            segments.append(current.joined(separator: "\n\n"))
        }

        return segments
    }
}

struct FreeReadRenderItem: Identifiable {
    let id = UUID()
    let content: FreeReadFeedItem
}

struct FreeReadView: View {
    private let likesStorageKey = "freeReadLikedPassageIDs"
    private let batchSize = 24
    private let prefetchThreshold = 8

    @State private var feed: [FreeReadRenderItem] = []
    @State private var seedPool: [FreeReadFeedItem] = []
    @State private var seedCursor: Int = 0
    @State private var likedPassageIDs: Set<Int> = Set(UserDefaults.standard.array(forKey: "freeReadLikedPassageIDs") as? [Int] ?? [])

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(feed.enumerated()), id: \.element.id) { index, item in
                        FreeReadCard(
                            item: item.content,
                            isLiked: likedPassageIDs.contains(item.content.passage.id),
                            onLike: { toggleLike(for: item.content) }
                        )
                        .frame(width: geo.size.width, height: geo.size.height)
                        .onAppear {
                            if index >= feed.count - prefetchThreshold {
                                appendBatch()
                            }
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .background(DS.bg)
        }
        .background(DS.bg)
        .onAppear {
            bootFeedIfNeeded()
        }
    }

    private func bootFeedIfNeeded() {
        guard feed.isEmpty else { return }
        seedPool = FreeReadFeedItem.seedPool.shuffled()
        appendBatch()
        appendBatch()
    }

    private func appendBatch() {
        guard !FreeReadFeedItem.seedPool.isEmpty else { return }
        if seedPool.isEmpty { seedPool = FreeReadFeedItem.seedPool.shuffled() }

        var newItems: [FreeReadRenderItem] = []
        newItems.reserveCapacity(batchSize)

        for _ in 0..<batchSize {
            if seedCursor >= seedPool.count {
                seedPool.shuffle()
                seedCursor = 0
            }
            newItems.append(FreeReadRenderItem(content: seedPool[seedCursor]))
            seedCursor += 1
        }

        feed.append(contentsOf: newItems)
    }

    private func toggleLike(for item: FreeReadFeedItem) {
        if likedPassageIDs.contains(item.passage.id) {
            likedPassageIDs.remove(item.passage.id)
        } else {
            likedPassageIDs.insert(item.passage.id)
        }
        UserDefaults.standard.set(Array(likedPassageIDs), forKey: likesStorageKey)
    }
}

struct FreeReadCard: View {
    let item: FreeReadFeedItem
    let isLiked: Bool
    let onLike: () -> Void

    private var likeCount: Int { item.baseLikeCount + (isLiked ? 1 : 0) }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(
                colors: [
                    DS.bg,
                    item.passage.category.color.opacity(0.26),
                    DS.bg
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                LinearGradient(
                    colors: [Color.black.opacity(0.1), Color.black.opacity(0.0), Color.black.opacity(0.28)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()

            contentOverlay
                .padding(.leading, 20)
                .padding(.trailing, 88)
                .padding(.bottom, 32)

            actionRail
                .padding(.trailing, 12)
                .padding(.bottom, 88)
        }
        .background(DS.bg)
    }

    private var contentOverlay: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            HStack(spacing: 8) {
                Text(item.passage.category.rawValue.uppercased())
                    .font(.system(size: 11, weight: .black))
                    .tracking(0.8)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(item.passage.category.color)
                    .clipShape(Capsule())

                Text("Part \(item.segmentIndex)/\(item.totalSegments)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(DS.label4)
            }
            .padding(.bottom, 10)

            Text(item.passage.title)
                .font(.system(size: 24, weight: .bold))
                .tracking(-0.5)
                .lineLimit(2)
                .foregroundStyle(.white)
                .padding(.bottom, 10)

            Text(item.excerpt)
                .font(.system(size: 16.5, weight: .medium))
                .lineSpacing(6)
                .foregroundStyle(DS.label2)
                .lineLimit(18)
                .padding(.bottom, 10)

            HStack(spacing: 5) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 10, weight: .bold))
                Text("Swipe for next")
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundStyle(DS.label4)
        }
    }

    private var actionRail: some View {
        VStack(spacing: 18) {
            Button(action: onLike) {
                VStack(spacing: 5) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundStyle(isLiked ? .red : .white)
                        .frame(width: 48, height: 48)
                        .background(Color.black.opacity(0.28))
                        .clipShape(Circle())

                    Text(formatCount(likeCount))
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.plain)

            ShareLink(item: item.shareText) {
                VStack(spacing: 5) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(Color.black.opacity(0.28))
                        .clipShape(Circle())

                    Text("Share")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
        }
    }

    private func formatCount(_ value: Int) -> String {
        if value >= 1_000_000 {
            return String(format: "%.1fM", Double(value) / 1_000_000).replacingOccurrences(of: ".0M", with: "M")
        }
        if value >= 1_000 {
            return String(format: "%.1fK", Double(value) / 1_000).replacingOccurrences(of: ".0K", with: "K")
        }
        return "\(value)"
    }
}

// MARK: - Home View

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var mgr: ReadingManager
    @EnvironmentObject var screenTime: ScreenTimeManager
    @State private var showScreenTimeSetup = false
    @State private var showPersonalization = false
    @AppStorage("personalizationCategoryCSV") private var personalizationCategoryCSV = ""
    @AppStorage("personalizationPrompt") private var personalizationPrompt = ""

    private let discoverTopics: [(icon: String, title: String, color: Color, category: PassageCategory)] = [
        ("person.crop.circle.badge.checkmark", "Self-Growth", Color(hex: "9BA96B"), .psychology),
        ("bubble.left.and.text.bubble.right", "Communication", Color(hex: "C7AE73"), .philosophy),
        ("briefcase", "Career & Business", Color(hex: "A87757"), .economics),
        ("book.closed", "Fiction", Color(hex: "8F9978"), .literature),
        ("banknote", "Finance & Economics", Color(hex: "7A8F59"), .economics),
        ("heart", "Relationships", Color(hex: "B7846A"), .psychology),
    ]

    private let moodPrompts: [(title: String, subtitle: String)] = [
        ("Taking a late walk", "wanting something reflective"),
        ("Before a hard conversation", "wanting clear words"),
        ("When focus feels low", "wanting sharp concentration"),
        ("After a long day", "wanting calm and reset"),
    ]

    private var preferredCategories: Set<PassageCategory> {
        decodeStoredCategories(from: personalizationCategoryCSV)
    }

    private var personalizedFeed: [Passage] {
        let all = PassageLibrary.all
        guard !preferredCategories.isEmpty else { return all }

        let prioritized = all.filter { preferredCategories.contains($0.category) }
        let fallback = all.filter { !preferredCategories.contains($0.category) }
        return prioritized + fallback
    }

    private var featuredPassages: [Passage] {
        Array(personalizedFeed.prefix(6))
    }

    private var communityPassages: [Passage] {
        let feed = personalizedFeed
        if feed.count <= 6 { return feed }
        return Array(feed.dropFirst(6).prefix(6))
    }

    private var quickStartPassages: [Passage] {
        Array(personalizedFeed.prefix(3))
    }

    private var discoverSubtitle: String {
        if !personalizationPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return personalizationPrompt
        }
        if !preferredCategories.isEmpty {
            return "Your learning plan is active. Pick what to dive into next."
        }
        return "Hey \(appState.userName.isEmpty ? "Reader" : appState.userName), pick what to learn next."
    }

    private var featuredTitle: String {
        preferredCategories.isEmpty ? "Featured" : "For You"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Discover")
                                .font(.system(size: 42, weight: .bold, design: .serif))
                                .tracking(-0.8)
                            Text(discoverSubtitle)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(DS.label3)
                        }
                        Spacer()

                        Button {
                            appState.selectedTab = .library
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 42, height: 42)
                                .background(DS.surface2)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.bottom, 14)

                    CreateLessonPromptCard {
                        showPersonalization = true
                    }
                    .padding(.bottom, 14)

                    if !preferredCategories.isEmpty {
                        PersonalizedPlanSummaryCard(
                            selectedCategories: preferredCategories,
                            customPrompt: personalizationPrompt
                        ) {
                            showPersonalization = true
                        }
                        .padding(.bottom, 14)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(discoverTopics, id: \.title) { topic in
                                DiscoverTopicChip(
                                    icon: topic.icon,
                                    title: topic.title,
                                    color: topic.color,
                                    isSelected: preferredCategories.contains(topic.category)
                                ) {
                                    togglePreferredCategory(topic.category)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)

                    Text(featuredTitle)
                        .font(.system(size: 42, weight: .bold, design: .serif))
                        .tracking(-0.7)
                        .padding(.bottom, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(featuredPassages) { passage in
                                FeaturedLessonCard(passage: passage) {
                                    appState.startReading(passage)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 22)

                    Text("Learn by mood")
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .tracking(-0.7)
                        .padding(.bottom, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(moodPrompts, id: \.title) { mood in
                                MoodPromptCard(title: mood.title, subtitle: mood.subtitle)
                            }
                        }
                    }
                    .padding(.bottom, 22)

                    Text("More creations by community")
                        .font(.system(size: 36, weight: .bold, design: .serif))
                        .tracking(-0.6)
                        .padding(.bottom, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(communityPassages) { passage in
                                FeaturedLessonCard(passage: passage, compact: true) {
                                    appState.startReading(passage)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 22)

                    Text("Daily Guardrails")
                        .font(.system(size: 32, weight: .bold, design: .serif))
                        .tracking(-0.5)
                        .padding(.bottom, 10)

                    UnlockBudgetCard()
                    .padding(.bottom, 12)

                    if !appState.isPremiumUser {
                        UpgradeStrip {
                            appState.presentPaywall(from: .settings)
                        }
                        .padding(.bottom, 18)
                    }

                    if !screenTime.isAuthorized || !screenTime.hasSelection {
                        ScreenTimeSetupStrip {
                            showScreenTimeSetup = true
                        }
                        .padding(.bottom, 16)
                    } else {
                        ScreenTimeActiveCard(
                            protectedItems: screenTime.selectedItemsCount,
                            monitoringEnabled: screenTime.isMonitoring,
                            onTap: { showScreenTimeSetup = true }
                        )
                        .padding(.bottom, 16)
                    }
                    
                    // Stats row
                    HStack(spacing: 8) {
                        StatCard(value: "\(mgr.totalReadings)", label: "Readings")
                        StatCard(value: "\(mgr.totalMinutesRead)", label: "Minutes")
                        StatCard(value: "\(Int(mgr.quizAccuracy * 100))%", label: "Accuracy")
                    }
                    .padding(.bottom, 24)
                    
                    // Blocked apps
                    SectionHeader(
                        title: "Today's Apps",
                        trailing: "\(mgr.lockedCount) blocked"
                    )
                    .padding(.bottom, 12)
                    
                    ForEach(mgr.enabledApps) { app in
                        BlockedAppRow(app: app) {
                            if app.isLocked {
                                if appState.canUnlockBlockedApps {
                                    appState.navigate(to: .blockedOverlay(app))
                                } else {
                                    appState.presentPaywall(from: .unlockLimitReached)
                                }
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.bottom, 16)
                    
                    // Suggested readings
                    SectionHeader(
                        title: preferredCategories.isEmpty ? "Quick Starts" : "Quick Starts for Your Plan",
                        trailing: "See All",
                        trailingAction: { appState.selectedTab = .library }
                    )
                    .padding(.bottom, 12)
                    
                    ForEach(quickStartPassages) { passage in
                        ReadingCard(passage: passage) {
                            appState.startReading(passage)
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal, DS.screenPadding)
                .padding(.bottom, 20)
            }
            .background(DS.bg)
            .navigationBarHidden(true)
        }
        .onAppear {
            appState.refreshDailyUnlockCreditsIfNeeded()
            screenTime.bootstrap()
        }
        .sheet(isPresented: $showScreenTimeSetup) {
            ScreenTimeSetupView()
                .environmentObject(screenTime)
        }
        .fullScreenCover(isPresented: $showPersonalization) {
            PersonalizationPlanView(
                isPresented: $showPersonalization,
                storedCategoryCSV: $personalizationCategoryCSV,
                customPrompt: $personalizationPrompt
            )
        }
    }

    private func togglePreferredCategory(_ category: PassageCategory) {
        var updated = preferredCategories
        if updated.contains(category) {
            updated.remove(category)
        } else {
            updated.insert(category)
        }
        personalizationCategoryCSV = encodeStoredCategories(updated)
    }
}

struct CreateLessonPromptCard: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Make My Own Lesson")
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .tracking(-0.4)
                        .foregroundStyle(.white)
                    Text("Describe what you want to learn and we’ll build a reading path.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(DS.label3)
                        .lineLimit(2)
                }

                Spacer(minLength: 0)

                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 12, weight: .bold))
                    Text("Create")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.white)
                .clipShape(Capsule())
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: [Color(hex: "2A2418"), Color(hex: "1E2417"), Color(hex: "162013")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct DiscoverTopicChip: View {
    let icon: String
    let title: String
    let color: Color
    var isSelected: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(isSelected ? .black : color)

                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isSelected ? .black : DS.label2)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isSelected ? color : DS.surface)
            .clipShape(Capsule())
            .overlay(
                Capsule().strokeBorder(isSelected ? color : DS.separator, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct PersonalizedPlanSummaryCard: View {
    let selectedCategories: Set<PassageCategory>
    let customPrompt: String
    let editAction: () -> Void

    private var summaryText: String {
        let prompt = customPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        if !prompt.isEmpty { return prompt }
        return selectedCategories
            .map(\.rawValue)
            .sorted()
            .joined(separator: " • ")
    }

    var body: some View {
        Button(action: editAction) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 11)
                    .fill(DS.accent.opacity(0.18))
                    .frame(width: 42, height: 42)
                    .overlay(
                        Image(systemName: "sparkles")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(DS.accent)
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text("Your Personal Learning Plan")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(summaryText)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(DS.label3)
                        .lineLimit(2)
                }

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(DS.label3)
            }
            .padding(12)
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(DS.separator, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct PersonalizationPlan: Identifiable {
    let id: String
    let title: String
    let planCount: Int
    let categories: Set<PassageCategory>
    let symbol: String
    let colors: [Color]
}

struct PersonalizationPlanView: View {
    @Binding var isPresented: Bool
    @Binding var storedCategoryCSV: String
    @Binding var customPrompt: String

    @State private var draftPrompt = ""
    @State private var selectedCategories: Set<PassageCategory> = []

    private let planCards: [PersonalizationPlan] = [
        PersonalizationPlan(
            id: "career",
            title: "Career & Leadership",
            planCount: 12,
            categories: [.economics, .technology, .history],
            symbol: "person.crop.square.filled.and.at.rectangle",
            colors: [Color(hex: "30464F"), Color(hex: "6C5F46"), Color(hex: "1A1F1A")]
        ),
        PersonalizationPlan(
            id: "finance",
            title: "Finance",
            planCount: 6,
            categories: [.economics, .mathematics],
            symbol: "banknote.fill",
            colors: [Color(hex: "1E2C33"), Color(hex: "3B2A1D"), Color(hex: "141A18")]
        ),
        PersonalizationPlan(
            id: "philosophy-history",
            title: "Philosophy & History",
            planCount: 9,
            categories: [.philosophy, .history, .literature],
            symbol: "building.columns.fill",
            colors: [Color(hex: "26333A"), Color(hex: "5C5642"), Color(hex: "171A16")]
        ),
        PersonalizationPlan(
            id: "productivity",
            title: "Productivity",
            planCount: 7,
            categories: [.psychology, .technology, .science],
            symbol: "clock.fill",
            colors: [Color(hex: "2C3E4A"), Color(hex: "6A6046"), Color(hex: "191D18")]
        ),
        PersonalizationPlan(
            id: "relationships",
            title: "Relationships",
            planCount: 8,
            categories: [.psychology, .literature],
            symbol: "person.2.fill",
            colors: [Color(hex: "2E414B"), Color(hex: "5E6D76"), Color(hex: "1A1C1A")]
        ),
        PersonalizationPlan(
            id: "social-skills",
            title: "Social Skills",
            planCount: 14,
            categories: [.psychology, .philosophy],
            symbol: "person.3.fill",
            colors: [Color(hex: "21303A"), Color(hex: "544B39"), Color(hex: "181B17")]
        ),
    ]

    private let categoryColumns = [GridItem(.adaptive(minimum: 112), spacing: 8)]
    private let planColumns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [DS.bg, Color(hex: "0D100D"), Color(hex: "080907")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        offerBanner
                            .padding(.bottom, 18)

                        Text("Build my own")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .padding(.bottom, 8)

                        TextEditor(text: $draftPrompt)
                            .scrollContentBackground(.hidden)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(minHeight: 88, maxHeight: 120)
                            .padding(12)
                            .background(DS.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(DS.separator, lineWidth: 1)
                            )
                            .padding(.bottom, 10)
                            .overlay(alignment: .topLeading) {
                                if draftPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    Text("I want to get better at public speaking and confidence...")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(DS.label4)
                                        .padding(.leading, 24)
                                        .padding(.top, 24)
                                        .allowsHitTesting(false)
                                }
                            }

                        Button {
                            generatePlanFromPrompt()
                        } label: {
                            HStack(spacing: 7) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12, weight: .bold))
                                Text("Generate my plan")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "EAE3D8"))
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                        .padding(.bottom, 18)

                        Text("Trending plans")
                            .font(.system(size: 34, weight: .bold, design: .serif))
                            .tracking(-0.6)
                            .padding(.bottom, 10)

                        LazyVGrid(columns: planColumns, spacing: 10) {
                            ForEach(planCards) { plan in
                                PersonalizationPlanCard(
                                    plan: plan,
                                    isSelected: plan.categories.isSubset(of: selectedCategories)
                                ) {
                                    togglePlan(plan)
                                }
                            }
                        }
                        .padding(.bottom, 20)

                        Text("Fine tune your categories")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 10)

                        LazyVGrid(columns: categoryColumns, spacing: 8) {
                            ForEach(PassageCategory.allCases, id: \.self) { category in
                                Button {
                                    toggleCategory(category)
                                } label: {
                                    Text(category.rawValue)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(selectedCategories.contains(category) ? .black : DS.label2)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(selectedCategories.contains(category) ? category.color : DS.surface)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(selectedCategories.contains(category) ? category.color : DS.separator, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    Text("\(selectedCategories.count) categories selected")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(DS.label3)

                    PrimaryButton(title: "Save My Plan", icon: "checkmark") {
                        saveAndClose()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(
                    LinearGradient(
                        colors: [DS.bg.opacity(0.0), DS.bg.opacity(0.94), DS.bg],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .onAppear {
            selectedCategories = decodeStoredCategories(from: storedCategoryCSV)
            draftPrompt = customPrompt
        }
    }

    private var header: some View {
        HStack {
            Text("Set my plan")
                .font(.system(size: 42, weight: .bold, design: .serif))
                .tracking(-0.7)

            Spacer()

            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(DS.label3)
                    .frame(width: 36, height: 36)
                    .background(DS.surface2)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 6)
        .padding(.bottom, 14)
    }

    private var offerBanner: some View {
        HStack {
            Text("Special Offer")
                .font(.system(size: 13, weight: .bold))
            Spacer()
            Text("Save 40%+ with annual plan")
                .font(.system(size: 13, weight: .bold))
        }
        .foregroundStyle(.black.opacity(0.8))
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            LinearGradient(
                colors: [Color(hex: "A89A7A"), Color(hex: "C2B58E"), Color(hex: "8E8272")],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func togglePlan(_ plan: PersonalizationPlan) {
        if plan.categories.isSubset(of: selectedCategories) {
            selectedCategories.subtract(plan.categories)
        } else {
            selectedCategories.formUnion(plan.categories)
        }
    }

    private func toggleCategory(_ category: PassageCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    private func saveAndClose() {
        storedCategoryCSV = encodeStoredCategories(selectedCategories)
        customPrompt = draftPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        isPresented = false
    }

    private func generatePlanFromPrompt() {
        let prompt = draftPrompt.lowercased()
        guard !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        let keywordMap: [(PassageCategory, [String])] = [
            (.economics, ["finance", "money", "business", "career", "invest"]),
            (.psychology, ["mind", "habit", "focus", "confidence", "social", "relationship"]),
            (.history, ["history", "ancient", "war", "civilization", "rome"]),
            (.philosophy, ["philosophy", "stoic", "ethics", "meaning", "thinking"]),
            (.science, ["science", "biology", "physics", "brain", "health"]),
            (.technology, ["tech", "ai", "startup", "coding", "digital"]),
            (.literature, ["fiction", "story", "books", "writing", "novel"]),
            (.mathematics, ["math", "quant", "logic", "statistics", "data"]),
        ]

        var inferred: Set<PassageCategory> = []
        for (category, keywords) in keywordMap where keywords.contains(where: { prompt.contains($0) }) {
            inferred.insert(category)
        }

        if inferred.isEmpty {
            inferred = [.psychology, .history, .science]
        }

        withAnimation(.easeInOut(duration: 0.25)) {
            selectedCategories.formUnion(inferred)
        }
    }
}

struct PersonalizationPlanCard: View {
    let plan: PersonalizationPlan
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: plan.colors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                RadialGradient(
                    colors: [Color.white.opacity(0.18), Color.clear],
                    center: .topLeading,
                    startRadius: 10,
                    endRadius: 120
                )

                Image(systemName: plan.symbol)
                    .font(.system(size: 74, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.2))
                    .offset(x: 44, y: 8)

                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.0), Color.black.opacity(0.68)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text("\(plan.planCount) plans")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.84))
                }
                .padding(12)
            }
            .frame(height: 146)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(isSelected ? DS.accent : Color.white.opacity(0.16), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct FeaturedLessonCard: View {
    let passage: Passage
    var compact: Bool = false
    let action: () -> Void

    private var cardWidth: CGFloat { compact ? 150 : 176 }
    private var cardHeight: CGFloat { compact ? 188 : 246 }
    private var sourceCount: Int { 4 + ((passage.id * 7) % 35) }

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [
                                passage.category.color.opacity(0.85),
                                Color.black.opacity(0.75),
                                passage.category.color.opacity(0.35),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                VStack(alignment: .leading, spacing: 0) {
                    Text(passage.title)
                        .font(.system(size: compact ? 20 : 28, weight: .bold, design: .serif))
                        .tracking(-0.4)
                        .foregroundStyle(.white)
                        .lineLimit(compact ? 3 : 4)
                        .padding(.bottom, 8)

                    Text("\(sourceCount) sources")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(12)
            }
            .frame(width: cardWidth, height: cardHeight)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(Color.white.opacity(0.12), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct MoodPromptCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(2)

            Text(subtitle)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(DS.label3)
                .lineLimit(2)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(width: 290, alignment: .leading)
        .background(DS.surface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(DS.separator, lineWidth: 1)
        )
    }
}

struct UnlockBudgetCard: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(DS.accent.opacity(0.16))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: appState.isPremiumUser ? "infinity" : "lock.open.fill")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(DS.accent)
                )

            VStack(alignment: .leading, spacing: 3) {
                Text("Today's Unlock Budget")
                    .font(.system(size: 14, weight: .semibold))
                Text(appState.isPremiumUser
                     ? "Unlimited unlocks and unlimited reads with Pro"
                     : "\(appState.freeUnlockCreditsRemaining)/\(AppState.dailyFreeUnlockLimit) free unlocks · \(appState.freeReadCreditsRemaining)/\(AppState.dailyFreeReadLimit) free reads")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(DS.label3)
            }

            Spacer()
        }
        .padding(14)
        .background(
            LinearGradient(
                colors: [DS.surface, DS.surface2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(DS.separator, lineWidth: 1)
        )
    }
}

struct UpgradeStrip: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 28, height: 28)
                    .background(DS.accent)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 1) {
                    Text("Go Pro for unlimited unlocks")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(DS.label2)
                    Text("No daily cap, full reading library, advanced stats")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(DS.label4)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(DS.label3)
            }
            .padding(12)
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(DS.separator, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ScreenTimeSetupStrip: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "lock.shield")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 28, height: 28)
                    .background(.orange)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 1) {
                    Text("Finish Screen Time setup")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(DS.label2)
                    Text("Grant access and choose apps to block for real")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(DS.label4)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(DS.label3)
            }
            .padding(12)
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(DS.separator, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

struct ScreenTimeActiveCard: View {
    let protectedItems: Int
    let monitoringEnabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.green)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Screen Time is active")
                        .font(.system(size: 14, weight: .semibold))
                    Text("\(protectedItems) protected items • \(monitoringEnabled ? "Monitoring on" : "Monitoring off")")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(DS.label3)
                }

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(DS.label3)
            }
            .padding(12)
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(DS.separator, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Blocked App Row

struct BlockedAppRow: View {
    let app: BlockedApp
    let onTap: () -> Void
    
    var iconText: String {
        switch app.id {
        case "instagram": return "📷"
        case "tiktok": return "🎵"
        case "twitter": return "𝕏"
        case "youtube": return "▶️"
        case "snapchat": return "👻"
        case "reddit": return "🤖"
        default: return "📱"
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Text(iconText)
                    .font(.system(size: 22))
                    .frame(width: 40, height: 40)
                    .background(DS.surface2)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(app.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(DS.label)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 10))
                        Text("\(app.usedMinutes)/\(app.dailyLimitMinutes) min")
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(DS.label4)
                    
                    // Progress bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(DS.surface3)
                                .frame(height: 4)
                            
                            Capsule()
                                .fill(app.barColor)
                                .frame(width: geo.size.width * min(1, app.usagePercent), height: 4)
                        }
                    }
                    .frame(height: 4)
                    .padding(.top, 4)
                }
                
                Text(app.isLocked ? "LOCKED" : "OPEN")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(0.3)
                    .foregroundStyle(app.isLocked ? .red : .green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(app.isLocked ? Color.red.opacity(0.12) : Color.green.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(14)
            .background(DS.surface)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

private func decodeStoredCategories(from rawValue: String) -> Set<PassageCategory> {
    Set(rawValue.split(separator: ",").compactMap { PassageCategory(rawValue: String($0)) })
}

private func encodeStoredCategories(_ categories: Set<PassageCategory>) -> String {
    categories
        .map(\.rawValue)
        .sorted()
        .joined(separator: ",")
}
