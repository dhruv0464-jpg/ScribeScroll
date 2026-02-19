# Screen Time Extensions Setup

These files are templates for the three extension targets required for full Screen Time enforcement.

## 1) Add Capabilities

For the main app target and all extension targets:

1. Open `Signing & Capabilities`.
2. Add `Family Controls`.
3. Add `App Groups`.
4. Use the same App Group in all targets: `group.com.dhruv.readtounlock`.

## 2) Create Extension Targets

In Xcode:

1. `File > New > Target > Device Activity Monitor Extension`
2. `File > New > Target > Shield Configuration Extension`
3. `File > New > Target > Shield Action Extension`

## 3) Add Template Files to Matching Targets

- Add `Extensions/Common/ScreenTimeExtensionShared.swift` to all three extension targets.
- Add `Extensions/DeviceActivityMonitorExtension/DeviceActivityMonitorExtension.swift` to the monitor target.
- Add `Extensions/ShieldConfigurationExtension/ShieldConfigurationExtension.swift` to the configuration target.
- Add `Extensions/ShieldActionExtension/ShieldActionExtension.swift` to the action target.

Do not add these extension files to your main app target.

## 4) Ensure Main App Uses Same Keys

The main app already stores app selection under:

- App Group: `group.com.dhruv.readtounlock`
- Key: `screenTime.selection.data`

The extensions read the same key and apply shields consistently.
