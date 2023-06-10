import UIKit

public extension UIViewController {

    static func loadFromNib(bundle: Bundle) -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            T.init(nibName: String(describing: T.self), bundle: bundle)
        }

        return instantiateFromNib()
    }
}
