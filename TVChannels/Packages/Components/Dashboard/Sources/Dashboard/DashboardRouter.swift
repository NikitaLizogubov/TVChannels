import UIKit

protocol DashboardRouter {
    func onTap()
}

public final class DashboardRouterImpl {

    public enum Event {
        case onTap
    }

    public struct Dependencies {

        public init() { }
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
        let view = DashboardViewImpl()
        let presenter = DashboardPresenterImpl()
        let interactor = DashboardInteractorImpl()
        let router = DashboardRouterImpl(onEvent: onEvent)

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        router.view = view

        return view
    }
}

// MARK: - DashboardRouter

extension DashboardRouterImpl: DashboardRouter {

    func onTap() {
        onEvent(.onTap)
    }
}
