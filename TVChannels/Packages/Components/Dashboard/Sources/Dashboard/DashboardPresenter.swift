import Foundation
import DashboardTypes

protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func channelInfoLoadingFinished(_ channelInfo: [ChannelInfo])
    func showProgramGuide(by indexPath: IndexPath)
    func showError(_ message: String)
}

final class DashboardPresenter {

    // MARK: - Public properties

    weak var view: DashboardViewProtocol?
    var interactor: DashboardInteractorProtocol?
    var router: DashboardRouterProtocol?

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

// MARK: - DashboardPresenterProtocol

extension DashboardPresenter: DashboardPresenterProtocol {

    func viewDidLoad() {
        view?.startLoading()
        interactor?.loadData()
    }

    func channelInfoLoadingFinished(_ channelInfo: [ChannelInfo]) {
        self.channelInfo = channelInfo

        let cellViewModels = channelInfo.map {
            ChannelCellViewModel(channel: $0.channel)
        }

        view?.stopLoading()
        view?.showChannels(cellViewModels)

        showProgramGuide(by: IndexPath(row: .zero, section: .zero))
    }

    func showProgramGuide(by indexPath: IndexPath) {
        let channelInfo = channelInfo[indexPath.row]
        let cellViewModels = makeProgramViewModels(channelInfo.programs)

        view?.showPrograms(cellViewModels)

        selectedChannelInfo = channelInfo
    }

    func showError(_ message: String) {
        view?.stopLoading()

        router?.showError(message)
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
