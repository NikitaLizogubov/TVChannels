import Foundation

public protocol RequestProvidable {
    func request<ResponseBody: Decodable>(
        with requestData: RequestDataProvidable,
        completion: @escaping (Result<ResponseBody?, NetworkError>) -> Void
    )

    func request<ResponseBody: Decodable>(
        with requestData: RequestDataProvidable,
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        completion: @escaping (Result<ResponseBody?, NetworkError>) -> Void
    )
}

public final class Network {

    // MARK: - Lifecycle

    public init() { }

    // MARK: - Private properties

    private let requestFactory = RequestFactory()
    private let urlSession: URLSession = {
        // TODO: - Implement cashing
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()

    // MARK: - Private methods

    private func processError(_ error: Error?) -> NetworkError {
        guard let error = error as NSError?, error.domain == NSURLErrorDomain else {
            return .noInternetConnection
        }

        switch error.code {
        case NSURLErrorNotConnectedToInternet:
            return .noInternetConnection
        case NSURLErrorCancelled:
            return .cancelled
        default:
            return .noInternetConnection
        }
    }
}

// MARK: - RequestProvidable

extension Network: RequestProvidable {

    public func request<ResponseBody: Decodable>(
        with requestData: RequestDataProvidable,
        completion: @escaping (Result<ResponseBody?, NetworkError>) -> Void
    ) {
        request(
            with: requestData,
            decoder: JSONDecoder(),
            completionQueue: .main,
            completion: completion
        )
    }

    public func request<ResponseBody: Decodable>(
        with requestData: RequestDataProvidable,
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        completion: @escaping (Result<ResponseBody?, NetworkError>) -> Void
    ) {
        guard let request = requestFactory.makeRequest(requestData) else {
            completion(.failure(.urlRequestCreationFailed))
            return
        }

        let task = urlSession.dataTask(with: request) { [self] data, response, error in
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                let processedError = processError(error)
                return completionQueue.async {
                    completion(.failure(processedError))
                }
            }

            let result: Result<ResponseBody?, NetworkError>
            switch httpResponse.statusCode {
            case 200..<300:
                guard let data = data, !data.isEmpty else {
                    result = .success(nil)
                    break
                }

                let decodedData = try? decoder.decode(ResponseBody.self, from: data)

                result = .success(decodedData)
            default:
                result = .failure(.unsuccessfulStatusCode)
            }

            completionQueue.async {
                completion(result)
            }
        }
        task.resume()
    }
}
