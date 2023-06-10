import UIKit

protocol DashboardView: AnyObject {

}

final class DashboardViewImpl: UIViewController {

    // MARK: - Public properties

    var presenter: DashboardPresenter?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(self) -> 💫")

        setupView()
        presenter?.viewDidLoad()
    }

    deinit {
        print("\(self) -> ☠️")
    }

    // MARK: - Private methods

    private func setupView() {
        view.backgroundColor = .blue

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("button", for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .primaryActionTriggered)

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions

    @objc
    private func didTap(_ sender: Any) {

    }
}

// MARK: - DashboardView

extension DashboardViewImpl: DashboardView {

}
