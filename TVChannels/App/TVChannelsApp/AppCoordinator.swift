import UIKit
import Dashboard

final class AppCoordinator {

    var window: UIWindow?

    init() {
        self.window = makeWindow()
    }

    private func makeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    private func makeRootViewController() -> UIViewController {
        let dependencies = DashboardRouterImpl.Dependencies()
        let view = DashboardRouterImpl.build(with: dependencies) { [weak self] event in
            switch event {
            case .onTap:
                print("----")
                let view = DashboardRouterImpl.build(with: .init()) { _ in
                    print("----")
                    (self?.window?.rootViewController as? UINavigationController)?.popViewController(animated: true)
                }
                (self?.window?.rootViewController as? UINavigationController)?.pushViewController(view, animated: true)
            }
        }
        return UINavigationController(rootViewController: view)
    }
}
