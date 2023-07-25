//
//  HomeController.swift
//  iCrypto
//
//  Created by Arina on 24.07.2023.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Variables
    private let coins: [Coin] = Coin.getMockArray()
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.reuseID)
        return table
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.backgroundColor = .systemBackground
    }

    // MARK: - UI Setup
    private func setView() {
        view.addSubview(tableView)
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

// MARK: - TableView setup
extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.reuseID, for: indexPath) as? CoinCell else { fatalError() }
        
        let coin = self.coins[indexPath.row]
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
    }
}
