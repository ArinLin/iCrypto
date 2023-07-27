//
//  HomeControllerViewModel.swift
//  iCrypto
//
//  Created by Arina on 26.07.2023.
//

import Foundation

class HomeControllerViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    
    init() {
        self.fetchCoins()
    }
    
    private (set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success (let coins):
                self?.coins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}
