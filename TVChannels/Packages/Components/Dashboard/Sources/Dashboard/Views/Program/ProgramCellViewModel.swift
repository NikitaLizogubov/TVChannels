import UIKit
import DashboardTypes

protocol ProgramCellViewModelInput {
    var name: String { get }
    var startTime: String { get }

    var nameColor: UIColor { get }
    var startTimeColor: UIColor { get }

    var backgroundColor: UIColor { get }
    var focusBackgroundColor: UIColor { get }
}

typealias ProgramCellViewModelProtocol = ProgramCellViewModelInput & ProgramGuideViewModel

struct ProgramCellViewModel: ProgramCellViewModelProtocol {

    // MARK: - Public properties

    let name: String
    let startTime: String

    let nameColor: UIColor = .black
    let startTimeColor: UIColor = .black

    let backgroundColor: UIColor = .white
    let focusBackgroundColor: UIColor = .systemYellow

    // MARK: - Private properties

    private let selectionHandler: () -> Void

    // MARK: - Init

    init(
        program: Program,
        dateFormatter: DateFormatter,
        selectionHandler: @escaping () -> Void
    ) {
        self.name = program.name
        self.startTime = dateFormatter.string(from: program.startTime)
        self.selectionHandler = selectionHandler
    }

    // MARK: - Public methods

    func didSelect() {
        selectionHandler()
    }
}
