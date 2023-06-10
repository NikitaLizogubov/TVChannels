import Foundation

protocol DashboardPresenter: AnyObject {
    func viewDidLoad()
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
}
