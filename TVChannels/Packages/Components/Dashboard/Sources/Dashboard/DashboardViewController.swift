import UIKit
import CommonUI

protocol DashboardViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()

    func showChannels(_ channelViewModels: [ChannelCellViewModelProtocol])
}

final class DashboardViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var channelTableVIew: UITableView! {
        didSet {
            channelTableVIew.dataSource = self
            channelTableVIew.delegate = self
            channelTableVIew.register(ChannelTableViewCell.loadFromNib(bundle: .module), forCellReuseIdentifier: ChannelTableViewCell.identifier)
        }
    }
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!

    // MARK: - Public properties

    var presenter: DashboardPresenterProtocol?

    // MARK: - Private methods

    private var channelViewModels: [ChannelCellViewModelProtocol] = []

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

        channelTableVIew.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channelViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.identifier, for: indexPath) as! ChannelTableViewCell
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
