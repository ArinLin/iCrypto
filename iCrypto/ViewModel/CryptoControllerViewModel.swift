//
//  CryptoControllerViewModel.swift
//  iCrypto
//
//  Created by Arina on 25.07.2023.
//

import Foundation
import UIKit

class CryptoControllerViewModel {
    
    var onImageLoaded: ((UIImage?)->Void)?
    
    // MARK: - Variables
    let coin: Coin
    
    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        loadImage()
    }
    
    private func loadImage() {
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL) ,
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
//        let imageData = try? Data(contentsOf: coin.logoURL!)
//        if let imageData = imageData {
//            DispatchQueue.main.async { [weak self] in
//                self?.coinLogo.image = UIImage(data: imageData)
//            }
//        }
    }
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
    }
}
