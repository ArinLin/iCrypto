//
//  HomeController.swift
//  iCrypto
//
//  Created by Arina on 24.07.2023.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Variables
    
    private let viewModel: HomeControllerViewModel
//    private let coins: [Coin] = [
//        Coin(id: 1, name: "Bitcoin", maxSupply: 300, rank: 1, pricingData: PricingData(CAD: CAD(price: 35000, market_cap: 259382))),
//        Coin(id: 2, name: "Ether", maxSupply: 200, rank: 2, pricingData: PricingData(CAD: CAD(price: 30000, market_cap: 259370))),
//        Coin(id: 3, name: "Dodge", maxSupply: 300, rank: 3, pricingData: PricingData(CAD: CAD(price: 25000, market_cap: 25938))),
//                ]
    
    // MARK: - UI Components
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseID)
        return table
    }()
    
    // MARK: - LifeCycle
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupSearchController()
        setConstraints()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                self?.present (alert, animated: true, completion: nil)
            }
        }
        self.view.backgroundColor = .systemBackground
    }

    // MARK: - UI Setup
    private func setView() {
        self.navigationItem.title = "iCrypto"
        
        view.addSubview(tableView)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search coins"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.showsBookmarkButton = true
        
        self.searchController.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .bookmark, state: .normal)
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

// MARK: - Search Controller setup
extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("DEBUG PRINT:", searchController.searchBar.text)
        viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}

extension HomeController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("DEBUG PRINT:", "button clicked")
    }
}

// MARK: - TableView setup
extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.allCoins.count
        let inSearchMode = self.viewModel.inSearchMode(searchController: searchController)
       
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.allCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseID, for: indexPath) as? CoinCell else { fatalError() }
        
        let inSearchMode = self.viewModel.inSearchMode(searchController: searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
//        let coin = viewModel.allCoins[indexPath.row]
        cell.configure(with: coin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController: searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
//        let coin = viewModel.allCoins[indexPath.row]
        let vm = CryptoControllerViewModel(coin)
        let vc = CryptoController(vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
