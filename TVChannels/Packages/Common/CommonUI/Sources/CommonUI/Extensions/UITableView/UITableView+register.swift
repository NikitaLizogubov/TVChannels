import UIKit

public extension UITableView {

    func register(cellTypes: UITableViewCell.Type..., bundle: Bundle) {
        cellTypes.forEach {
            register($0.loadFromNib(bundle: bundle), forCellReuseIdentifier: $0.identifier)
        }
    }
}
