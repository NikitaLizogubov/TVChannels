import Foundation

protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func channelInfoLoadingFinished(_ channelInfo: [ChannelInfo])
    func showProgramGuide(by indexPath: IndexPath)
}

final class DashboardPresenter {

    // MARK: - Public properties

    weak var view: DashboardViewProtocol?
    var interactor: DashboardInteractorProtocol?
    var router: DashboardRouterProtocol?

    // MARK: - Private properties

    private var channelInfo: [ChannelInfo] = []

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
        interactor?.loadData()
    }

    func channelInfoLoadingFinished(_ channelInfo: [ChannelInfo]) {
        self.channelInfo = channelInfo

        let cellViewModels = channelInfo.map {
            ChannelCellViewModel(info: $0)
        }

        view?.stopLoading()
        view?.showChannels(cellViewModels)
    }

    func showProgramGuide(by indexPath: IndexPath) {
        let program = channelInfo[indexPath.row].programs

        print(program)
    }
}
