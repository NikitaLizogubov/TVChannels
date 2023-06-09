import Foundation

protocol DashboardPresenter: AnyObject {
    func viewDidLoad()
    func didTap()
}

final class DashboardPresenterImpl {

    weak var view: DashboardView?
    var interactor: DashboardInteractor?
    var router: DashboardRouter?

    init() {
        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardPresenter

extension DashboardPresenterImpl: DashboardPresenter {

    func viewDidLoad() {

    }

    func didTap() {
        router?.onTap()
    }
}
