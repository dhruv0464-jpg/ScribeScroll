import ManagedSettings
import UserNotifications

final class ShieldActionExtension: ShieldActionDelegate {
    override func handle(
        action: ShieldAction,
        for application: ApplicationToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        _ = application
        switch action {
        case .primaryButtonPressed:
            notifyMainApp()
            completionHandler(.defer)

        case .secondaryButtonPressed:
            completionHandler(.close)

        @unknown default:
            completionHandler(.close)
        }
    }
    
    override func handle(
        action: ShieldAction,
        for webDomain: WebDomainToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        _ = action
        _ = webDomain
        completionHandler(.close)
    }
    
    override func handle(
        action: ShieldAction,
        for category: ActivityCategoryToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void
    ) {
        _ = action
        _ = category
        completionHandler(.close)
    }

    private func notifyMainApp() {
        let content = UNMutableNotificationContent()
        content.title = "Read to Unlock"
        content.body = "Open the app and pass a quick reading quiz to unlock."
        content.sound = .default
        let request = UNNotificationRequest(
            identifier: "readToUnlock.shieldAction",
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request)
    }
}
