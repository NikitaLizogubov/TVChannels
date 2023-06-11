import UIKit

public final class AlertBuilder {

    // MARK: - Public properties

    public let alertController: UIAlertController

    // MARK: - Init

    public init(style: UIAlertController.Style) {
        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: style)
    }

    private init(_ alertController: UIAlertController) {
        self.alertController = alertController
    }
}

// MARK: - Public

public extension AlertBuilder {

    func title(_ text: String) -> AlertBuilder {
        alertController.title = text
        return AlertBuilder(alertController)
    }

    func message(_ text: String) -> AlertBuilder {
        alertController.message = text
        return AlertBuilder(alertController)
    }

    func button(_ title: String, style: UIAlertAction.Style, completionHandler: ((UIAlertController) -> Void)?) -> AlertBuilder {
        let action = UIAlertAction(title: title, style: style) { (alertAction) in
            completionHandler?(self.alertController)
        }
        alertController.addAction(action)
        return AlertBuilder(alertController)
    }
}
