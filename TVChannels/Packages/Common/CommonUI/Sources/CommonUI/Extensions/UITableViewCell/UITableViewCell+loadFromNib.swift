import UIKit

public extension UITableViewCell {

    static func loadFromNib(bundle: Bundle) -> UINib {
        UINib(nibName: String(describing: self), bundle: bundle)
    }

    static var identifier: String {
        String(describing: self) + ".identifier"
    }
}
