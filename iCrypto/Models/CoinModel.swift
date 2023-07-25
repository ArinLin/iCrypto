//
//  CoinModel.swift
//  iCrypto
//
//  Created by Arina on 25.07.2023.
//

import Foundation

struct Coin {
    let id: Int
    let name: String
    let max_supply: Int?
    let cmc_rank: Int
    let quote: Quote
    
    struct Quote {
        let CAD: CAD
        
        struct CAD {
            let price: Double
            let market_cap: Double
        }
    }
}

extension Coin {
    
    public static func getMockArray() -> [Coin] {
        return
        [
            Coin(id: 1, name: "Bitcoin", max_supply: 300, cmc_rank: 1, quote: Quote(CAD: Quote.CAD(price: 35000, market_cap: 259382))),
            Coin(id: 2, name: "Ether", max_supply: 200, cmc_rank: 2, quote: Quote(CAD: Quote.CAD(price: 30000, market_cap: 259370))),
            Coin(id: 3, name: "Dodge", max_supply: 300, cmc_rank: 3, quote: Quote(CAD: Quote.CAD(price: 25000, market_cap: 25938))),
        ]
    }
}
