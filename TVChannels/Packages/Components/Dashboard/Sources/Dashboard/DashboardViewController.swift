import UIKit
import CommonUI

protocol DashboardViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()

    func showChannels(_ channelViewModels: [ChannelCellViewModelProtocol])
    func showPrograms(_ programGuideViewModels: [ProgramGuideViewModel])
}

final class DashboardViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var channelTableView: UITableView! {
        didSet {
            channelTableView.dataSource = self
            channelTableView.delegate = self
            channelTableView.register(cellTypes: ChannelTableViewCell.self, bundle: .module)
        }
    }
    @IBOutlet private weak var programCollectionView: UICollectionView! {
        didSet {
            programCollectionView.dataSource = self
            programCollectionView.delegate = self
            programCollectionView.register(
                cellTypes: TimeLineCollectionViewCell.self, ProgramCollectionViewCell.self,
                bundle: .module
            )
        }
    }

    // MARK: - Public properties

    var presenter: DashboardPresenterProtocol?
    var programLayout: ProgramLayout?

    // MARK: - Private methods

    private var channelViewModels: [ChannelCellViewModelProtocol] = []
    private var programGuideViewModels: [ProgramGuideViewModel] = []

    private let collectionCellViewFactory = ProgramCellFactory()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(self) -> 💫")

        presenter?.viewDidLoad()
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardViewProtocol

extension DashboardViewController: DashboardViewProtocol {

    func startLoading() {
        loadingView.isHidden = false
    }

    func stopLoading() {
        loadingView.isHidden = true
    }

    func showChannels(_ channelViewModels: [ChannelCellViewModelProtocol]) {
        self.channelViewModels = channelViewModels

        channelTableView.reloadData()
    }

    func showPrograms(_ programGuideViewModels: [ProgramGuideViewModel]) {
        self.programGuideViewModels = programGuideViewModels

        programCollectionView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channelViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChannelTableViewCell.identifier,
            for: indexPath
        ) as! ChannelTableViewCell

        cell.viewModel = channelViewModels[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showProgramGuide(by: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension DashboardViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        programGuideViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionCellViewFactory.makeCell(
            collectionView: collectionView,
            viewModel: programGuideViewModels[indexPath.row],
            indexPath: indexPath
        )
    }
}

// MARK: - UICollectionViewDelegate

extension DashboardViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        programGuideViewModels[indexPath.row].didSelect()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DashboardViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        programLayout?.size(bounds: collectionView.bounds, viewModel: programGuideViewModels[indexPath.row]) ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        programLayout?.grid.lineSpacing ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        programLayout?.grid.interitemSpacing ?? .zero
    }
}
