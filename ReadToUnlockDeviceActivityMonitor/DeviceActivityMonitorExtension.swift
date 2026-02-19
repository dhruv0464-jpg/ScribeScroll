import Foundation
import DeviceActivity
import FamilyControls
import ManagedSettings

private enum Shared {
    static let appGroupID = "group.com.dhruv.readtounlock"
    static let selectionStorageKey = "screenTime.selection.data"
}

private extension DeviceActivityName {
    static let readToUnlockDaily = Self("readToUnlockDaily")
}

private extension DeviceActivityEvent.Name {
    static let readToUnlockThreshold = Self("readToUnlockThreshold")
}

private extension ManagedSettingsStore.Name {
    static let readToUnlock = Self("readToUnlock")
}

private func loadStoredSelection() -> FamilyActivitySelection {
    guard
        let defaults = UserDefaults(suiteName: Shared.appGroupID),
        let data = defaults.data(forKey: Shared.selectionStorageKey),
        let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
    else {
        return FamilyActivitySelection()
    }
    return decoded
}

final class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    private let store = ManagedSettingsStore(named: .readToUnlock)

    override func intervalDidStart(for activity: DeviceActivityName) {
        guard activity == .readToUnlockDaily else { return }
        applySelectionShields()
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        guard activity == .readToUnlockDaily else { return }
        clearShields()
    }
    
    override func eventDidReachThreshold(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName
    ) {
        guard activity == .readToUnlockDaily else { return }
        if event == .readToUnlockThreshold {
            applySelectionShields()
        }
    }

    private func applySelectionShields() {
        let selection = loadStoredSelection()
        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = .specific(selection.categoryTokens)
    }

    private func clearShields() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
}
