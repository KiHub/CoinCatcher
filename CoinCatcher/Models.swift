//
//  Models.swift
//  CoinCatcher
//
//  Created by  Mr.Ki on 07.04.2022.
//

import Foundation

struct Crypto: Codable{
    let asset_id: String?
    let name: String?
    let price_usd: Float?
    let id_icon: String?
    
    
    
//    enum CodingKeys: String, CodingKey {
//        case asset_id = "id"
//        case name = "name"
//        case price_usd = "piceUsd"
//        case id_icon = "icon"
//    }
    
}

struct Icon: Codable {
    let asset_id: String
    let url: String
}
