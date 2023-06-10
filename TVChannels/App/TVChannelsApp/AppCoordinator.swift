import UIKit
import Network
import Dashboard

final class AppCoordinator {

    // MARK: - Public properties

    var window: UIWindow?

    // MARK: - Private properties

    private let network: RequestProvidable = Network()

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
        let dependencies = DashboardRouterImpl.Dependencies(
            network: network
        )
        let view = DashboardRouterImpl.build(with: dependencies) { _ in
            // TODO: Implement navigation to other modules
        }
        return view
    }
}
