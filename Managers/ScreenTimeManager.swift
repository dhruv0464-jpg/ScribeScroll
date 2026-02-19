import Foundation
import Combine
#if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
import FamilyControls
import ManagedSettings
import DeviceActivity
#endif

class ScreenTimeManager: ObservableObject {
    
    static let shared = ScreenTimeManager()
    
    @Published var isAuthorized = false
    @Published var authorizationError: String?
    @Published var isFrameworkSupported = false
    @Published var isApplyingShields = false
    @Published var isMonitoring = false

    #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
    @Published var selectedApps = FamilyActivitySelection()
    private let store = ManagedSettingsStore(named: .readToUnlock)
    #endif

    private let selectionStorageKey = ScreenTimeShared.selectionStorageKey

    private var selectionDefaults: UserDefaults {
        UserDefaults(suiteName: ScreenTimeShared.appGroupID) ?? .standard
    }
    
    init() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        isFrameworkSupported = true
        #else
        isFrameworkSupported = false
        #endif

        bootstrap()
    }

    func bootstrap() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        loadPersistedSelection()
        isAuthorized = AuthorizationCenter.shared.authorizationStatus == .approved
        #else
        isAuthorized = false
        #endif
    }

    var selectedItemsCount: Int {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        return selectedApps.applicationTokens.count
            + selectedApps.categoryTokens.count
            + selectedApps.webDomainTokens.count
        #else
        return 0
        #endif
    }

    var hasSelection: Bool {
        selectedItemsCount > 0
    }

    func requestAuthorization() async {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            await MainActor.run {
                self.isAuthorized = true
                self.authorizationError = nil
            }
        } catch {
            await MainActor.run {
                self.isAuthorized = false
                self.authorizationError = error.localizedDescription
            }
        }
        #else
        await MainActor.run {
            self.isAuthorized = false
            self.authorizationError = "Screen Time frameworks unavailable in this build environment."
        }
        #endif
    }
    
    func setSelectedApps(_ selection: Any) {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        if let typed = selection as? FamilyActivitySelection {
            selectedApps = typed
            persistSelection()
        }
        #endif
    }

    func configureSelection(_ selection: Any) {
        setSelectedApps(selection)
        applyShieldsForSelection()
        startMonitoring()
    }

    func applyShields(for appTokens: Set<String>) {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        // The demo app still passes string IDs for sample UI flows.
        // Real shielding always uses FamilyActivitySelection tokens.
        _ = appTokens
        applyShieldsForSelection()
        #else
        print("[ScreenTime] Framework unavailable. Requested shields: \(appTokens.count)")
        #endif
    }

    func applyShieldsForSelection() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        guard isAuthorized else {
            authorizationError = "Authorize Screen Time access first."
            return
        }
        guard hasSelection else {
            authorizationError = "Select apps or categories to shield first."
            return
        }

        isApplyingShields = true
        store.shield.applications = selectedApps.applicationTokens
        store.shield.applicationCategories = .specific(selectedApps.categoryTokens)
        authorizationError = nil
        #endif
    }
    
    func clearShields() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        isApplyingShields = false
        #endif
    }

    func removeShields(for appToken: String, duration: TimeInterval = 900) {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        _ = appToken
        clearShields()

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.applyShieldsForSelection()
        }
        #else
        print("[ScreenTime] Framework unavailable. Temporary unblock request for \(appToken).")
        #endif
    }

    func startMonitoring() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        guard isAuthorized else {
            authorizationError = "Authorize Screen Time access first."
            return
        }
        let center = DeviceActivityCenter()
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        do {
            try center.startMonitoring(.readToUnlockDaily, during: schedule)
            isMonitoring = true
        } catch {
            authorizationError = "Monitoring failed: \(error.localizedDescription)"
            isMonitoring = false
        }
        #else
        print("[ScreenTime] Monitoring unavailable in this build environment.")
        #endif
    }
    
    func stopMonitoring() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        DeviceActivityCenter().stopMonitoring([.readToUnlockDaily])
        isMonitoring = false
        #else
        print("[ScreenTime] Monitoring unavailable in this build environment.")
        #endif
    }

    private func persistSelection() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        do {
            let data = try JSONEncoder().encode(selectedApps)
            selectionDefaults.set(data, forKey: selectionStorageKey)
        } catch {
            authorizationError = "Couldn't save selected apps: \(error.localizedDescription)"
        }
        #endif
    }

    private func loadPersistedSelection() {
        #if canImport(FamilyControls) && canImport(ManagedSettings) && canImport(DeviceActivity)
        guard let data = selectionDefaults.data(forKey: selectionStorageKey) else { return }
        do {
            selectedApps = try JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        } catch {
            authorizationError = "Couldn't restore selected apps: \(error.localizedDescription)"
        }
        #endif
    }
}
