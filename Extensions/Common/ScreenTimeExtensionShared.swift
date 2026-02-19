import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

enum ScreenTimeExtensionShared {
    static let appGroupID = "group.com.dhruv.readtounlock"
    static let selectionStorageKey = "screenTime.selection.data"
}

extension DeviceActivityName {
    static let readToUnlockDaily = Self("readToUnlockDaily")
}

extension DeviceActivityEvent.Name {
    static let readToUnlockThreshold = Self("readToUnlockThreshold")
}

extension ManagedSettingsStore.Name {
    static let readToUnlock = Self("readToUnlock")
}

func loadStoredSelection() -> FamilyActivitySelection {
    guard
        let defaults = UserDefaults(suiteName: ScreenTimeExtensionShared.appGroupID),
        let data = defaults.data(forKey: ScreenTimeExtensionShared.selectionStorageKey),
        let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
    else {
        return FamilyActivitySelection()
    }
    return decoded
}
