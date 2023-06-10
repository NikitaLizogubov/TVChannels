import UIKit
import Network
import CommonUI

protocol DashboardRouterProtocol {
    
}

public final class DashboardRouter {

    public enum Event {

    }

    public struct Dependencies {

        let network: RequestProvidable
        let dateFormatter: DateFormatter

        public init(
            network: RequestProvidable,
            dateFormatter: DateFormatter
        ) {
            self.network = network
            self.dateFormatter = dateFormatter
        }
    }

    // MARK: - Internal properties

    weak var view: UIViewController?

    // MARK: - Private properties

    private let onEvent: (Event) -> Void

    // MARK: - Lifecycle

    init(onEvent: @escaping (Event) -> Void) {
        self.onEvent = onEvent

        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }

    // MARK: - Public methods

    public static func build(
        with dependencies: Dependencies,
        onEvent: @escaping (Event) -> Void
    ) -> UIViewController {
        let view = DashboardViewController.loadFromNib(bundle: .module)
        let presenter = DashboardPresenter()
        let interactor = DashboardInteractor(
            network: dependencies.network,
            dateFormatter: dependencies.dateFormatter
        )
        let router = DashboardRouter(onEvent: onEvent)

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        router.view = view

        return view
    }
}

// MARK: - DashboardRouterProtocol

extension DashboardRouter: DashboardRouterProtocol {

}
