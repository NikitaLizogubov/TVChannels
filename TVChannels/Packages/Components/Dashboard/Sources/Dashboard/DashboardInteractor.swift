import Foundation

protocol DashboardInteractor {

}

final class DashboardInteractorImpl {

    weak var presenter: DashboardPresenter?

    init() {
        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardInteractor

extension DashboardInteractorImpl: DashboardInteractor {

}
