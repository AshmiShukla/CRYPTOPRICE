//
//  CoinManager.swift
//  CRYPTOPRICE
//
//  Created by ASHMIT SHUKLA on 16/06/21.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdateUI(Model:CoinModel)
    func didfailwitherror(error:Error)
}

struct CoinManager {
    var delegate:CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "C791CFDD-D537-46B9-A248-523AC912144E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func getPrice(currency:String,CurrencyType:String) {
        let urlString="\(baseURL)/\(currency)/\(CurrencyType)?apikey=\(apiKey)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString:String)  {
        let url=URL(string: urlString)
        let session=URLSession(configuration: .default)
        let task=session.dataTask(with: url!) { Data, response, error in
            if error != nil{
                print(error!)
                delegate?.didfailwitherror(error: error!)
            }
            else{
                if let safedata=Data{
                    if let ANS=parseJSON(currencyData: safedata){
                        print(ANS.rate)
                        delegate?.didUpdateUI(Model: ANS)
                    }
                
                }
            }
        }
        task.resume()
    }
    func parseJSON(currencyData:Data) ->CoinModel?  {
        let decoder=JSONDecoder()
        do{
            let data=try decoder.decode(CoinData.self, from: currencyData)
            let Model=CoinModel(rate: data.rate, CoinType: data.asset_id_base, ConvertedCurrency: data.asset_id_quote)
            return Model
        }
        catch{
            print(error)
            delegate?.didfailwitherror(error: error)
            return nil
        }
    }
    
}
