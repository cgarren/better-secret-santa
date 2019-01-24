//
//  Options.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/8/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class Options: UIViewController {

    @IBOutlet weak var Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = ViewController.MyVariables.group_name
    }
    
    @IBAction func Back(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "AddPeople") as! AddPeople
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Yes(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "BadPairings") as! BadPairings
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func No(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "PriceLimit") as! PriceLimit
        self.present(Controller, animated:false, completion:nil)
    }
    
}
