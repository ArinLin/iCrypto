//
//  CoinCell.swift
//  iCrypto
//
//  Created by Arina on 25.07.2023.
//

import UIKit
import SDWebImage

class CoinCell: UITableViewCell {
    static let reuseID = "CoinCell"
    
    // MARK: - Variables
    private(set) var coin: Coin!
    
    // MARK: - UI Components
    private let coinLogo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(systemName: "questionmark")
        logo.tintColor = .black
        return logo
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        self.coinName.text = coin.name
        
        self.coinLogo.sd_setImage(with: coin.logoURL)
        
//        DispatchQueue.global().async {
//        let imageData = try? Data(contentsOf: self.coin.logoURL!)
//            if let imageData = imageData {
//                DispatchQueue.main.async { [weak self] in
//                    self?.coinLogo.image = UIImage(data: imageData)
//                }
//            }
//        }
    }
    
    // TODO: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil
        self.coinLogo.image = nil
    }
    
    // MARK: - UI Setup
    private func setView() {
        self.addSubview(coinLogo)
        self.addSubview(coinName)
    }
    
    private func setConstraints() {
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
}
