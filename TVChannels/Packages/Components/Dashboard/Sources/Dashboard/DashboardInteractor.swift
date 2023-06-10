import Foundation
import Network

protocol DashboardInteractorProtocol {
    func loadChannels()
}

final class DashboardInteractor {

    // MARK: - Public properties

    weak var presenter: DashboardPresenterProtocol?

    // MARK: - Private properties

    private let network: RequestProvidable

    // MARK: - Lifecycle

    init(network: RequestProvidable) {
        self.network = network

        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardInteractorProtocol

extension DashboardInteractor: DashboardInteractorProtocol {

    func loadChannels() {
        let request = GETChannelsRequest()
        network.request(with: request) { [weak self] (result: Result<[Channel]?, NetworkError>) in
            switch result {
            case .success(let channels):
                guard let channels else { return }

                // Simulate slow internet
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.presenter?.channelsLoadingFinished(channels)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
