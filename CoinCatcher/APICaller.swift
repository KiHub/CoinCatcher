//
//  APICaller.swift
//  CoinCatcher
//
//  Created by  Mr.Ki on 07.04.2022.
//

import Foundation
import UIKit

final class APICaller {
    
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = "8F27EEDB-9BF2-46F4-A4CF-282D35F1375B"
        static let assets = "https://rest.coinapi.io/v1/assets/"
        static let icons = "https://rest.coinapi.io/v1/assets/icons/50/"
    }
    
    private init() {}
    
    public var icons: [Icon] = []
    
    private var whenReady: ((Result<[Crypto], Error>) -> Void)?
    
    public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void) {
        
        guard !icons.isEmpty else {
            whenReady = completion
            return
        }
        
        guard let url = URL(string: Constants.assets + "?apikey=" + Constants.apiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                //MARK: - Decode response
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptos))
//                completion(.success(cryptos.sorted { first, second -> Bool in
//                    return (first.price_usd ?? 0) > (second.price_usd ?? 0)
//                }))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
                
    }
    
    public func getAllIcons() {
        guard let url = URL(string: Constants.icons + "?apikey=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                //MARK: - Decode response
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReady {
                self?.getAllCryptoData(completion: completion)
                }
            } catch {
               print(error)
            }
            
        }.resume()
        
    }
    
}
