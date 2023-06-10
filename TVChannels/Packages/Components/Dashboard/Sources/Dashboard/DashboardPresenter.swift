import Foundation

protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func channelsLoadingFinished(_ channels: [Channel])
}

final class DashboardPresenter {

    // MARK: - Public properties

    weak var view: DashboardViewProtocol?
    var interactor: DashboardInteractorProtocol?
    var router: DashboardRouterProtocol?

    // MARK: - Lifecycle

    init() {
        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardPresenterProtocol

extension DashboardPresenter: DashboardPresenterProtocol {

    func viewDidLoad() {
        view?.startLoading()
        interactor?.loadChannels()
    }

    func channelsLoadingFinished(_ channels: [Channel]) {
        let cellViewModels = channels.map {
            ChannelCellViewModel(channel: $0)
        }

        view?.stopLoading()
        view?.showChannels(cellViewModels)
    }
}
