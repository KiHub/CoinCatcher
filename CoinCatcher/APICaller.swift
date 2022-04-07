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
        
    }
    
    private init() {}
    
    public func getAllCryptoData(completion: @escaping (Result<[Crypto], Error>) -> Void) {
        
        guard let url = URL(string: Constants.assets + "?apikey=" + Constants.apiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                //MARK: - Decode response
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(cryptos))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
                
    }
}
