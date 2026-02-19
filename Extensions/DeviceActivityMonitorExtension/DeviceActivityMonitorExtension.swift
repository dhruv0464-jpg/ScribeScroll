import DeviceActivity
import FamilyControls
import ManagedSettings

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
