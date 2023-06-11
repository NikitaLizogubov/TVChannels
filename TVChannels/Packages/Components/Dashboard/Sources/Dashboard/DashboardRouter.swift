import UIKit
import Network
import CommonUI
import DashboardTypes

protocol DashboardRouterProtocol {
    func showProgramDetails(_ program: Program)
    func showError(_ message: String)
}

public final class DashboardRouter {

    public enum Event {
        case programDetails(Program)
    }

    public struct Dependencies {

        let network: RequestProvidable
        let networkDateFormatter: DateFormatter
        let programDateFormatter: DateFormatter

        public init(
            network: RequestProvidable,
            networkDateFormatter: DateFormatter,
            programDateFormatter: DateFormatter
        ) {
            self.network = network
            self.networkDateFormatter = networkDateFormatter
            self.programDateFormatter = programDateFormatter
        }
    }

    // MARK: - Internal properties

    weak var viewController: UIViewController?

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
        let programLayout = ProgramLayout()
        let viewController = DashboardViewController.loadFromNib(bundle: .module)
        let presenter = DashboardPresenter(
            grid: programLayout.grid,
            dateFormatter: dependencies.programDateFormatter
        )
        let interactor = DashboardInteractor(
            network: dependencies.network,
            dateFormatter: dependencies.networkDateFormatter
        )
        let router = DashboardRouter(onEvent: onEvent)

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        viewController.presenter = presenter
        viewController.programLayout = programLayout
        router.viewController = viewController

        return viewController
    }
}

// MARK: - DashboardRouterProtocol

extension DashboardRouter: DashboardRouterProtocol {

    func showProgramDetails(_ program: Program) {
        onEvent(.programDetails(program))
    }

    func showError(_ message: String) {
        let alertViewController = AlertBuilder(style: .alert)
            .title("Error!")
            .message(message)
            .button("OK", style: .cancel, completionHandler: nil)
            .alertController

        viewController?.present(alertViewController, animated: true)
    }
}
