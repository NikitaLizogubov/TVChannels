import Foundation
import DashboardTypes

protocol DashboardPresenterProtocol {
    var view: DashboardPresenterToViewProtocol? { get set }
    var interactor: DashboardPresenterToInteractorProtocol? { get set }
    var router: DashboardPresenterToRouterProtocol? { get set }
}

protocol DashboardPresenterToInteractorProtocol {
    func loadData()
}

protocol DashboardPresenterToViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()

    func showChannels(_ channelViewModels: [ChannelCellViewModelProtocol])
    func showPrograms(_ programGuideViewModels: [ProgramGuideViewModel])
}

protocol DashboardPresenterToRouterProtocol {
    func showProgramDetails(_ program: Program)
    func showError(_ message: String)
}

final class DashboardPresenter {

    // MARK: - Public properties

    weak var view: DashboardPresenterToViewProtocol?
    var interactor: DashboardPresenterToInteractorProtocol?
    var router: DashboardPresenterToRouterProtocol?

    // MARK: - Private properties

    private let grid: Grid
    private let dateFormatter: DateFormatter

    private var channelInfo: [ChannelInfo] = []
    private var selectedChannelInfo: ChannelInfo?

    // MARK: - Lifecycle

    init(grid: Grid, dateFormatter: DateFormatter) {
        self.grid = grid
        self.dateFormatter = dateFormatter

        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardViewToPresenterProtocol

extension DashboardPresenter: DashboardIneractorToPresenterProtocol {

    func channelInfoLoadingFinished(_ channelInfo: [ChannelInfo]) {
        self.channelInfo = channelInfo

        let cellViewModels = channelInfo.map {
            ChannelCellViewModel(channel: $0.channel)
        }

        view?.stopLoading()
        view?.showChannels(cellViewModels)

        showProgramGuide(by: IndexPath(row: .zero, section: .zero))
    }

    func showError(_ message: String) {
        view?.stopLoading()

        router?.showError(message)
    }
}

// MARK: - DashboardViewToPresenterProtocol

extension DashboardPresenter: DashboardViewToPresenterProtocol {

    func viewDidLoad() {
        view?.startLoading()
        interactor?.loadData()
    }

    func showProgramGuide(by indexPath: IndexPath) {
        let channelInfo = channelInfo[indexPath.row]
        let cellViewModels = makeProgramViewModels(channelInfo.programs)

        view?.showPrograms(cellViewModels)

        selectedChannelInfo = channelInfo
    }
}

// MARK: - Private

private extension DashboardPresenter {

    func makeProgramViewModels(_ programs: [Program]) -> [ProgramGuideViewModel] {
        let step = Int(grid.numberOfItemsHorizontal)

        var programGuides: [ProgramGuideViewModel] = []
        programs.enumerated().forEach { index, program in
            if index % step == .zero {
                let endProgramIndex = index + step
                let endProgram = endProgramIndex > programs.count ? programs[programs.endIndex - 1] : programs[endProgramIndex - 1]

                programGuides.append(
                    TimeLineCellViewModel(
                        startTime: program.startTime,
                        endTime: endProgram.startTime,
                        dateFormatter: dateFormatter
                    )
                )
            }

            programGuides.append(
                ProgramCellViewModel(
                    program: program,
                    dateFormatter: dateFormatter,
                    selectionHandler: { [weak self] in
                        self?.router?.showProgramDetails(program)
                    }
                )
            )
        }
        return programGuides
    }
}
