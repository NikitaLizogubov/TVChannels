import Foundation

public enum NetworkError: Error {
    case urlRequestCreationFailed
    case noInternetConnection
    case cancelled
    case unsuccessfulStatusCode
}
