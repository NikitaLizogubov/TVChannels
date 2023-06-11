import Foundation
import Network
import DashboardTypes

protocol DashboardInteractorProtocol {
    func loadData()
}

final class DashboardInteractor {

    // MARK: - Public properties

    weak var presenter: DashboardPresenterProtocol?

    // MARK: - Private properties

    private let network: RequestProvidable
    private let dateFormatter: DateFormatter

    // MARK: - Lifecycle

    init(
        network: RequestProvidable,
        dateFormatter: DateFormatter
    ) {
        self.network = network
        self.dateFormatter = dateFormatter

        print("\(self) -> 💫")
    }

    deinit {
        print("\(self) -> ☠️")
    }
}

// MARK: - DashboardInteractorProtocol

extension DashboardInteractor: DashboardInteractorProtocol {

    func loadData() {
        let dispatchGroup = DispatchGroup()

        var channels: [Channel] = []
        var programs: [Program] = []
        var error: NetworkError?

        dispatchGroup.enter()
        loadChannels(
            onSuccess: {
                channels = $0
                dispatchGroup.leave()
            },
            onFailure: {
                error = $0
                dispatchGroup.leave()
            }
        )

        dispatchGroup.enter()
        loadProgram(
            onSuccess: {
                programs = $0
                dispatchGroup.leave()
            },
            onFailure: {
                error = $0
                dispatchGroup.leave()
            }
        )

        dispatchGroup.notify(queue: .main) { [self] in
            if let error {
                presenter?.showError(error.localizedDescription)
            } else {
                let infos = ChannelInfo.map(channels, programs)
                presenter?.channelInfoLoadingFinished(infos)
            }
        }
    }
}

// MARK: - Private

private extension DashboardInteractor {

    func loadChannels(
        onSuccess: @escaping ([Channel]) -> Void,
        onFailure: @escaping (NetworkError) -> Void
    ) {
        let request = GETChannelsRequest()
        network.request(with: request) { (result: Result<[Channel]?, NetworkError>) in
            switch result {
            case .success(let channels):
                guard let channels else { return }

                onSuccess(channels)
            case .failure(let error):
                onFailure(error)
            }
        }
    }

    func loadProgram(
        onSuccess: @escaping ([Program]) -> Void,
        onFailure: @escaping (NetworkError) -> Void
    ) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let request = GETProgramRequest()
        network.request(
            with: request,
            decoder: decoder,
            completionQueue: .main
        ) { (result: Result<[Program]?, NetworkError>) in
            switch result {
            case .success(let programs):
                guard let programs else { return }

                onSuccess(programs)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
