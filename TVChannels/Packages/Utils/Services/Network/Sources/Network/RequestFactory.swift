import Foundation

struct RequestFactory {

    func makeRequest(_ requestData: RequestDataProvidable) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "\(requestData.baseUrl)\(requestData.endpoint)") else {
            return nil
        }

        if !requestData.params.isEmpty {
            urlComponents.queryItems = requestData.params.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = urlComponents.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = requestData.method.rawValue
        request.allHTTPHeaderFields = requestData.headers

        return request
    }
}
