import UIKit

class CountryCell: UICollectionViewCell {
    static let identifier = "CountryCell"
    let flagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = AppColors.flagBorder.cgColor
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.header
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.subtitle
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let populationLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.placeholder
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private static var imageCache = NSCache<NSString, UIImage>()

    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupCell()
        
    }
    private func setupCell(){
        let Hstack = UIStackView(arrangedSubviews: [
            nameLabel, capitalLabel
        ])
        Hstack.axis = .horizontal
        Hstack.spacing = 8
        Hstack.alignment = .center
        Hstack.distribution = .fillProportionally
        Hstack.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [
            flagImage,
            Hstack,
            populationLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        contentView.backgroundColor = AppColors.cardBackground
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.06
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            
            flagImage.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func loadImage(from urlString: String) {
        if let cached = CountryCell.imageCache.object(forKey: urlString as NSString) {
            self.flagImage.image = cached
            return
        }
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                CountryCell.imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.flagImage.image = image
                }
            }
        }
    }
    func configure(with country: Country){
        flagImage.image = nil
        nameLabel.text = country.name.common
        loadImage(from: country.flags.png)
        capitalLabel.text = country.capital?.first ?? "N/A"
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        populationLabel.text = "Pop: \(formatter.string(from: NSNumber(value: country.population)) ?? "")"
        
    }
    
}
