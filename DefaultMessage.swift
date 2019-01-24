//
//  DefaultMessage.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/10/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class DefaultMessage: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = ViewController.MyVariables.group_name
        //Message!.layer.borderWidth = 1
        //Message!.layer.borderColor = UIColor.black.cgColor
        let line1 = "Dear (Name),\n"
        let line2 = "       Merry Christmas! You've been invited to join a Secret Santa group called "
        let line3 = "! You should buy a gift for (Name). The gift should cost about "
        let line4 = ". The date of the gift exchange is "
        let line5 = " and it will be held at "
        let line6 = ". It's time to get in the spirit, Ho Ho Ho!"
        let var1 = line1 + line2 +  ViewController.MyVariables.group_name + line3
        let var2 = ViewController.MyVariables.price_limit + line4 + ViewController.MyVariables.exchange_date
        let var3 = line5 + ViewController.MyVariables.location + line6
        Message.text = var1 + var2 + var3
    }
    
    @IBAction func Back(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "PriceLimit") as! PriceLimit
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Next(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Pairings") as! Pairings
        self.present(Controller, animated:false, completion:nil)
    }
    
    
}
