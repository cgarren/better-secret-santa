//
//  ViewController.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/6/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Button1: UIButton!
    struct MyVariables {
        static var group_name = ""
        static var people: [Int:Array<String>] = [:]
        //static var people = [1:["Name1", "Number1"], 2:["Name2", "Number2"], 3:["Name3", "Number3"], 4:["Name4", "Number4"], 5:["Name5", "Number5"], 6:["Name6", "Number6"], 7:["Name7", "Number7"], 8:["Name8", "Number8"], 9:["Name9", "Number9"], 10:["Name10", "Number10"]]
        static var bad_pairings: [Int:Int] = [:]
        //static var bad_pairings = [4:5, 2:7, 9:6]
        static var pairings: [Int:Int] = [:]
        static var exchange_date = ""
        static var price_limit = ""
        static var location = ""
        static var detailed_pairings: [Int:Array<String>] = [:]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Button1.backgroundColor = .clear
        Button1.layer.cornerRadius = 5
        Button1.layer.borderWidth = 1
        Button1.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func Button1(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "AddNew") as! AddNew
        
        self.present(Controller, animated:true, completion:nil)
    }
    
}
