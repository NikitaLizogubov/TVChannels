import UIKit
import Network
import Dashboard

final class AppCoordinator {

    // MARK: - Public properties

    var window: UIWindow?

    // MARK: - Private properties

    private let network: RequestProvidable = Network()

    private let networkDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    private let programDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter
    }()

    // MARK: - Init

    init() {
        self.window = makeWindow()
    }

    // MARK: - Private methods

    private func makeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    private func makeRootViewController() -> UIViewController {
        let dependencies = DashboardRouter.Dependencies(
            network: network,
            networkDateFormatter: networkDateFormatter,
            programDateFormatter: programDateFormatter
        )
        let view = DashboardRouter.build(with: dependencies) { _ in
            // TODO: Implement navigation to other modules
        }
        return view
    }
}
