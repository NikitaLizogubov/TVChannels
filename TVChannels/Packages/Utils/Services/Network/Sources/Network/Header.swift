import Foundation

public enum Header {}

extension Header {

    public enum Key: String {
        case contentType = "Content-Type"
    }
}

extension Header {

    public enum ContentType: String {
        case json = "application/json"
    }
}
