//
//  ViewController.swift
//  CRYPTOPRICE
//
//  Created by ASHMIT SHUKLA on 16/06/21.
//

import UIKit

class ViewController: UIViewController{
    var currency=CoinManager()
    var currencytype:String="AUD"
    @IBOutlet weak var SearchCurrency: UITextField!
    @IBOutlet weak var CurrncyType: UILabel!
    
    @IBOutlet weak var CurrencyImage: UIImageView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var PickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.dataSource=self
        PickerView.delegate=self
        SearchCurrency.delegate=self
        currency.delegate=self
        // Do any additional setup after loading the view.
    }

    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        if let CoinType = SearchCurrency.text{
            print(currencytype)
            currency.getPrice(currency:CoinType , CurrencyType: currencytype)
            
        }
    }
    
    
    
}
//MARK: - UIPICKERVIEWDATASOURCE
extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.currencyArray.count
    }
}
//MARK: - UIPICKERVIEWDELEGATE
extension ViewController:UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencytype=currency.currencyArray[row]
        if (SearchCurrency.text != "")
        {
            currency.getPrice(currency: SearchCurrency.text!, CurrencyType: currencytype)
        }
    }
}
//MARK: - UITEXTFIELD
extension ViewController:UITextFieldDelegate{
    

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text == "")
        {
            textField.placeholder="Type Something...."
                return false
        }
        else
        {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        SearchCurrency.endEditing(true)
        if(SearchCurrency.text != "")
        {
            currency.getPrice(currency: SearchCurrency.text!, CurrencyType: currencytype)
        }
        return true

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(SearchCurrency.text!)
        if let CoinType = SearchCurrency.text{
            print(currencytype)
            currency.getPrice(currency:CoinType , CurrencyType: currencytype)
            
        }
    }
    
}
//MARK: - DelegateToUpdateUI
extension ViewController:CoinManagerDelegate{
    func didUpdateUI(Model: CoinModel) {
        print(Model.ImageCoinType)
        DispatchQueue.main.async {
            self.Price.text=Model.rateString
            self.CurrncyType.text=Model.ConvertedCurrency
            self.CurrencyImage.image=UIImage(named: Model.ImageCoinType)
        }
    }
    
    func didfailwitherror(error: Error) {
        print(error)
    }
    
    
}

