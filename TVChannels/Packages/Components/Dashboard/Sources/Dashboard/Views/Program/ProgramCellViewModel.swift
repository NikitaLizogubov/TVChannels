import UIKit

protocol ProgramCellViewModelInput {
    var name: String { get }
    var startTime: String { get }

    var nameColor: UIColor { get }
    var startTimeColor: UIColor { get }
}

typealias ProgramCellViewModelProtocol = ProgramCellViewModelInput

struct ProgramCellViewModel: ProgramCellViewModelInput {

    // MARK: - Public properties

    let name: String
    let startTime: String

    let nameColor: UIColor = .black
    let startTimeColor: UIColor = .black

    // MARK: - Init

    init(program: Program, dateFormatter: DateFormatter) {
        self.name = program.name
        self.startTime = dateFormatter.string(from: program.startTime)
    }
}
