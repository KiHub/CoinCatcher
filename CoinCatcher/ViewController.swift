//
//  ViewController.swift
//  CoinCatcher
//
//  Created by  Mr.Ki on 07.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModels = [CryptoTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        
        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                print(models.count)
                self?.viewModels = models.compactMap({
                    
                    // To Do: Formatter
                    
                    CryptoTableViewCellViewModel(
                        name: $0.name ?? "N/A", symbol: $0.asset_id ?? "N/A", price: "$55")
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
                
            }
        }
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
    
    private func setup() {
        
 
        setupTable()
        
    }
    
    private func setupTable() {
        title = "Coin Catcher"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
    }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
