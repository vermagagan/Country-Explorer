import UIKit
class CountryDetailVC: UIViewController {

    var country: Country!

    private let flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.layer.borderColor = AppColors.flagBorder.cgColor
        image.layer.borderWidth = 1
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        title = country.name.common
        setupLayout()
        populateData()
        loadImage(from: country.flags.png)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(flagImage)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            flagImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            flagImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            flagImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            flagImage.heightAnchor.constraint(equalToConstant: 220),

            contentStack.topAnchor.constraint(equalTo: flagImage.bottomAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24)
        ])
    }

    private func populateData() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        let languages = country.languages?.values.joined(separator: ", ") ?? "N/A"
        let currency = country.currencies?.values
            .map { "\($0.name) (\($0.symbol ?? ""))" }
            .joined(separator: ", ") ?? "N/A"
        let population = formatter.string(from: NSNumber(value: country.population)) ?? "N/A"

        let rows: [(String, String)] = [
            ("Capital",    country.capital?.first ?? "N/A"),
            ("Region",     country.region),
            ("Subregion",  country.subregion ?? "N/A"),
            ("Population", population),
            ("Languages",  languages),
            ("Currency",   currency)
        ]

        for (index, row) in rows.enumerated() {
            let rowView = makeRow(key: row.0, value: row.1)
            contentStack.addArrangedSubview(rowView)

            // divider between rows — not after last
            if index < rows.count - 1 {
                let divider = makeDivider()
                contentStack.addArrangedSubview(divider)
            }
        }
    }

    private func makeRow(key: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let keyLabel = UILabel()
        keyLabel.text = key
        keyLabel.font = .systemFont(ofSize: 14, weight: .medium)
        keyLabel.textColor = AppColors.subtitle
        keyLabel.translatesAutoresizingMaskIntoConstraints = false

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        valueLabel.textColor = AppColors.header
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(keyLabel)
        container.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),

            keyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            keyLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            keyLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.35),

            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 8)
        ])

        return container
    }

    private func makeDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = AppColors.divider
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return divider
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.flagImage.image = image
                }
            }
        }
    }
}
