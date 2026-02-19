import Foundation
#if canImport(DeviceActivity)
import DeviceActivity
#endif
#if canImport(ManagedSettings)
import ManagedSettings
#endif

enum ScreenTimeShared {
    static let appGroupID = "group.com.dhruv.readtounlock"
    static let selectionStorageKey = "screenTime.selection.data"
    static let unlockDurationSeconds: TimeInterval = 15 * 60
}

#if canImport(DeviceActivity)
extension DeviceActivityName {
    static let readToUnlockDaily = Self("readToUnlockDaily")
}

extension DeviceActivityEvent.Name {
    static let readToUnlockThreshold = Self("readToUnlockThreshold")
}
#endif

#if canImport(ManagedSettings)
extension ManagedSettingsStore.Name {
    static let readToUnlock = Self("readToUnlock")
}
#endif
