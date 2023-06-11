import UIKit

final class TimeLineCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var endTimeLabel: UILabel!

    // MARK: - Public properties

    var viewModel: TimeLineCellViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }
}

// MARK: - Private

private extension TimeLineCollectionViewCell {

    private func bindViewModel() {
        guard let viewModel else { return }

        startTimeLabel.text = viewModel.startTime
        endTimeLabel.text = viewModel.endTime

        startTimeLabel.textColor = viewModel.startTimeColor
        endTimeLabel.textColor = viewModel.endTimeColor
    }
}
