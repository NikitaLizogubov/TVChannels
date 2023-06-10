import UIKit

final class ProgramCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var startTimeLabel: UILabel!

    // MARK: - Public properties

    var viewModel: ProgramCellViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
}

// MARK: - Private

private extension ProgramCollectionViewCell {

    private func setupUI() {
        containerView.layer.cornerRadius = 16.0
    }

    private func bindViewModel() {
        guard let viewModel else { return }

        nameLabel.text = viewModel.name
        startTimeLabel.text = viewModel.startTime

        nameLabel.textColor = viewModel.nameColor
        startTimeLabel.textColor = viewModel.startTimeColor
    }
}
