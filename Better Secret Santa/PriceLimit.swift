//
//  PriceLimit.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/8/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class PriceLimit: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var Next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = ViewController.MyVariables.group_name
        amount.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        amount.becomeFirstResponder()
        if amount.text == "" {
            Next.isEnabled = false
        } else {
            Next.isEnabled = true
        }
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
        
        if amount.text == "" {
            Next.isEnabled = false
        } else {
            Next.isEnabled = true
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Options") as! Options
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Next(_ sender: Any) {
        //var text2 = amount.text
        //text2 = text2?.replacingOccurrences(of: "$", with: "", options: String.CompareOptions.literal, range: nil)
        
        //let optionalString: String? = text2
        //if let string = optionalString, let dubl = Double(string){
            //print(dubl)
        ViewController.MyVariables.price_limit = amount.text ?? ""
        
        //print (amount.text)
        let Controller = storyboard?.instantiateViewController(withIdentifier: "DefaultMessage") as! DefaultMessage
        self.present(Controller, animated:false, completion:nil)
    }
    
}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
