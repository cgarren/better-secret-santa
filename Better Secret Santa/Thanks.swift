//
//  Thanks.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/12/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class Thanks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Return(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(Controller, animated:false, completion:nil)
    }
}
