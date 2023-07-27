//
//  HomeControllerViewModel.swift
//  iCrypto
//
//  Created by Arina on 26.07.2023.
//

import Foundation
import UIKit

class HomeControllerViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    init() {
        self.fetchCoins()
    }
    
    private (set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private (set) var filteredCoins: [Coin] = []
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success (let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}

// MARK: - Search Functions
extension HomeControllerViewModel {
    public func inSearchMode(searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController (searchBarText: String?) {
        self.filteredCoins = allCoins
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            
            self.filteredCoins = self.filteredCoins.filter({$0.name.lowercased().contains(searchText)})
        }
        self.onCoinsUpdated?()
    }
}
