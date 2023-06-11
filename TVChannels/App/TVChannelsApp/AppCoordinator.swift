import UIKit
import Network
import Dashboard
import DashboardTypes

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
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter
    }()

    // MARK: - Init

    init() {
        self.window = makeWindow()
    }
}

// MARK: - Private methods

private extension AppCoordinator {

    func makeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()
        return window
    }

    func makeRootViewController() -> UIViewController {
        // We can handle some app states to make required module
        makeDashboard()
    }

    func makeDashboard() -> UIViewController {
        let dependencies = DashboardRouter.Dependencies(
            network: network,
            networkDateFormatter: networkDateFormatter,
            programDateFormatter: programDateFormatter
        )
        let view = DashboardRouter.build(with: dependencies) { event in
            switch event {
            case .programDetails(let program):
                print("Navigate to program details with: \(program)")
                // TODO: - Add navigation
                //let viewController = makeProgramDetails(program)
                //...
            }
        }
        return view
    }

    func makeProgramDetails(_ program: Program) -> UIViewController {
        UIViewController()
    }
}
