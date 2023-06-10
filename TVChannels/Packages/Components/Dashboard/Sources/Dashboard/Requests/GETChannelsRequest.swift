import Foundation
import Network

struct GETChannelsRequest: RequestDataProvidable {

    var baseUrl: String {
        "https://demo-c.cdn.vmedia.ca"
    }

    var endpoint: String {
        "/json/Channels"
    }

    var headers: [String: String] {
        [
            Header.Key.contentType.rawValue: Header.ContentType.json.rawValue
        ]
    }
}
