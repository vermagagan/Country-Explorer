import UIKit

class CountryListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = AppColors.primary
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var countries:[Country] = []
    var filteredCountries:[Country] = []
    var currentCountry:[Country]{
        return isSearching ? filteredCountries : countries
    }
    private var isSearching : Bool{
           return searchController.isActive &&
           !(searchController.searchBar.text?.isEmpty ?? true)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupNav()
        setupCV()
        loadCountries()

    }

    
    private func setupNav(){
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.backgroundColor = AppColors.secondaryBackground
        definesPresentationContext = true
       }
    
    private func setupCV(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 10
        let cellwidth = (view.frame.width - (spacing*3))/2
        
        layout.itemSize = CGSize(width: cellwidth, height: cellwidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = AppColors.background
        
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
    }
    private func loadCountries(){
        spinner.startAnimating()
        NetworkManager.shared.fetchCountries{[weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                self?.spinner.stopAnimating()
                switch result{
                case .success(let fetchedCountries):
                    self?.countries = fetchedCountries.sorted{$0.name.common < $1.name.common}
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    self?.showError("\(error)")
                }
            }
        }
    }
    private func showError(_ message: String) {
        DispatchQueue.main.async {
            let label = UILabel()
            label.text = message
            label.textColor = AppColors.subtitle
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = true
            self.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentCountry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else { return UICollectionViewCell()}
        let item = currentCountry[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = currentCountry[indexPath.row]
        let vc = CountryDetailVC()
        vc.country = country
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
                       filteredCountries = countries.filter {
                           $0.name.common.lowercased().contains(searchText.lowercased())
                       }
        collectionView.reloadData()
    }

}

