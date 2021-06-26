//
//  CoinData.swift
//  CRYPTOPRICE
//
//  Created by ASHMIT SHUKLA on 16/06/21.
//

import Foundation
struct CoinData:Decodable {
    let rate:Double
    let asset_id_base:String
    let asset_id_quote:String
}
