//
//  BadPairings.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/8/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit
let animals = ["Cat", "Dog", "Cow", "Mulval"]
var first = 0
var second = 0

class BadPairings: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.MyVariables.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath)
        cell.textLabel?.text = ViewController.MyVariables.people[indexPath[1]+1]?[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(tableView.frame.minY)
        //print(ViewController.MyVariables.people[indexPath[1]+1])
        if (tableView.frame.minY <= 200) {
            first = indexPath[1]+1
        } else if  (tableView.frame.minY <= 600) {
            second = indexPath[1]+1
        } else {
            print ("error")
        }
    }
    
    @IBOutlet weak var Person1: UITableView!
    @IBOutlet weak var Person2: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func Back(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Options") as! Options
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Done(_ sender: UIButton) {
        ViewController.MyVariables.bad_pairings[first] = second
        
        let Controller = storyboard?.instantiateViewController(withIdentifier: "PriceLimit") as! PriceLimit
        self.present(Controller, animated:false, completion:nil)
    }
    
}
