import Foundation
import Network

struct GETProgramRequest: RequestDataProvidable {

    var baseUrl: String {
        "https://demo-c.cdn.vmedia.ca"
    }

    var endpoint: String {
        "/json/ProgramItems"
    }

    var headers: [String: String] {
        [
            Header.Key.contentType.rawValue: Header.ContentType.json.rawValue
        ]
    }
}
