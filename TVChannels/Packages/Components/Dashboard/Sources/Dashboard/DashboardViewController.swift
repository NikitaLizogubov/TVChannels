import UIKit
import CommonUI

protocol DashboardViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()

    func showChannels(_ channelViewModels: [ChannelCellViewModelProtocol])
    func showPrograms(_ programViewModels: [ProgramCellViewModelProtocol])
}

final class DashboardViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var channelTableVIew: UITableView! {
        didSet {
            channelTableVIew.dataSource = self
            channelTableVIew.delegate = self
        }
    }
    @IBOutlet private weak var programCollectionView: UICollectionView! {
        didSet {
            programCollectionView.dataSource = self
            programCollectionView.delegate = self
        }
    }

    // MARK: - Public properties

    var presenter: DashboardPresenterProtocol?

    // MARK: - Private methods

    private var channelViewModels: [ChannelCellViewModelProtocol] = []
    private var programViewModels: [ProgramCellViewModelProtocol] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(self) -> 💫")

        registerCells()

        presenter?.viewDidLoad()
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - Private methods

private extension DashboardViewController {

    func registerCells() {
        registerChannelCells()
        registerProgramCells()
    }

    func registerChannelCells() {
        [
            ChannelTableViewCell.self
        ].forEach {
            channelTableVIew.register($0.loadFromNib(bundle: .module), forCellReuseIdentifier: $0.identifier)
        }
    }

    func registerProgramCells() {
        [
            ProgramCollectionViewCell.self
        ].forEach {
            programCollectionView.register($0.loadFromNib(bundle: .module), forCellWithReuseIdentifier: $0.identifier)
        }
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

        channelTableVIew.reloadData()
    }

    func showPrograms(_ programViewModels: [ProgramCellViewModelProtocol]) {
        self.programViewModels = programViewModels

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
        programViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProgramCollectionViewCell.identifier,
            for: indexPath
        ) as! ProgramCollectionViewCell

        cell.viewModel = programViewModels[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DashboardViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 600.0, height: view.bounds.height / 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}
