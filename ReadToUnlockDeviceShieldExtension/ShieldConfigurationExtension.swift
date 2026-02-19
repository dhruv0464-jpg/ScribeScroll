import ManagedSettings
import ManagedSettingsUI
import UIKit

final class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        _ = application
        return makeConfiguration()
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        _ = application
        _ = category
        return makeConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        _ = webDomain
        return makeConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        _ = webDomain
        _ = category
        return makeConfiguration()
    }

    private func makeConfiguration() -> ShieldConfiguration {
        ShieldConfiguration(
            backgroundBlurStyle: .systemUltraThinMaterialDark,
            backgroundColor: UIColor.black,
            icon: UIImage(systemName: "book.fill"),
            title: ShieldConfiguration.Label(
                text: "Read to Unlock",
                color: UIColor.white
            ),
            subtitle: ShieldConfiguration.Label(
                text: "Complete a reading + quiz to unlock this app.",
                color: UIColor.secondaryLabel
            ),
            primaryButtonLabel: ShieldConfiguration.Label(
                text: "Open Read to Unlock",
                color: UIColor.black
            ),
            primaryButtonBackgroundColor: UIColor(red: 1.0, green: 0.79, blue: 0.23, alpha: 1.0),
            secondaryButtonLabel: ShieldConfiguration.Label(
                text: "Not Now",
                color: UIColor.secondaryLabel
            )
        )
    }
}
