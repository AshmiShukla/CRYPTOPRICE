//
//  CoinModel.swift
//  CRYPTOPRICE
//
//  Created by ASHMIT SHUKLA on 16/06/21.
//

import Foundation
struct CoinModel {
    let rate:Double
    let CoinType:String
    let ConvertedCurrency:String
    var rateString:String{
        return String(format: "%.2f", rate)
    }
    var ImageCoinType:String{
        return CoinType.lowercased()
    }
}
