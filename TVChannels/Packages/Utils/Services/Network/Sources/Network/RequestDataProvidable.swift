import Foundation

public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

public protocol RequestDataProvidable {
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: HttpMethod { get }
    var params: [String: String] { get }
    var headers: [String: String] { get }
}

public extension RequestDataProvidable {

    var method: HttpMethod {
        .get
    }

    var params: [String: String] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }
}
