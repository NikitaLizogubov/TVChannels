import UIKit

protocol TimeLineCellViewModelInput {
    var startTime: String { get }
    var endTime: String { get }

    var startTimeColor: UIColor { get }
    var endTimeColor: UIColor { get }
}

typealias TimeLineCellViewModelProtocol = TimeLineCellViewModelInput & ProgramGuideViewModel

struct TimeLineCellViewModel: TimeLineCellViewModelProtocol {

    // MARK: - Public properties

    let startTime: String
    let endTime: String

    let startTimeColor: UIColor = .black
    let endTimeColor: UIColor = .black

    // MARK: - Init

    init(startTime: Date, endTime: Date, dateFormatter: DateFormatter) {
        self.startTime = dateFormatter.string(from: startTime)
        self.endTime = dateFormatter.string(from: endTime)
    }
}
