//
//  Pairings.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/11/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class Pairings: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var Name: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.MyVariables.pairings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath)
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        let vari = ViewController.MyVariables.detailed_pairings[indexPath[1]]
        let var1 = String(vari![0])
        let var2 = String(vari![1])
        //print (var1)
        //print (var2)
        cell.textLabel?.text = var1 + " buys for " + var2
        return cell
    }
    

    @IBOutlet weak var Pairs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = ViewController.MyVariables.group_name
        makePairings()
        var i = 0
        for (key, value) in ViewController.MyVariables.pairings {
            let giver = ViewController.MyVariables.people[key]?[0]
            let reciever = ViewController.MyVariables.people[value]?[0]
            ViewController.MyVariables.detailed_pairings[i] = [giver, reciever] as? [String]
            //print (ViewController.MyVariables.detailed_pairings)
            i = i + 1
        }
        //print (ViewController.MyVariables.detailed_pairings)
    }
    
    @IBAction func Back(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "DefaultMessage") as! DefaultMessage
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Next(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you done with the list?", message: "If you continue, the current event will disappear.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.openThanksView()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    @IBAction func Recalculate(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Pairings") as! Pairings
        self.present(Controller, animated:false, completion:nil)
    }
    
    func validate(key_to_check: Int, value_to_check: Int, bad_pairings: Dictionary<Int, Int>) -> Bool {
        for (key, value) in bad_pairings {
            if key == key_to_check {
                if value == value_to_check {
                    return false
                }
            }
        }
        return true
        //if key == badpairings key AND number == badparinings value
        //iterate through badpairings to find correct key, then see if the value is equal to value_tocheck
    }
    
    func makePairings() {
        let bad_pairings = ViewController.MyVariables.bad_pairings
        let people = ViewController.MyVariables.people
        var potential_pairs = ViewController.MyVariables.people
        var pairings: [Int:Int] = [:]
        
        //print (bad_pairings)
        //print ("People:", people)
        
        for (key, value) in people {
            //print ("Person:", key)
            //print (value)
            var available = false
            var validated = false
            var number = Int.random(in: 0 ..< people.count)
            for (keyn, valuen) in potential_pairs {
                if number == keyn {
                    available = true
                    break
                } else {
                    available = false
                }
            }
            
            validated = validate(key_to_check: key, value_to_check: number, bad_pairings: bad_pairings)
            
            //Checks:
            //1.generated number is the person
            //2.person has already been assigned
            //3.the pairing is bad as specified by the user
            while number == key || available == false || validated == false {
                print ("availiable:", available)
                print ("valiadted:", validated)
                print ("generated number:", number)
                print (potential_pairs)
                number = Int.random(in: 0 ..< people.count+1)
                for (keyn, valuen) in potential_pairs {
                    //print (keyn)
                    if number == keyn {
                        available = true
                        break
                    } else {
                        available = false
                    }
                }
                validated = validate(key_to_check: key, value_to_check: number, bad_pairings: bad_pairings)
                //print ("")
            }
            //print("Final number: ", number)
            potential_pairs.removeValue(forKey: number)
            pairings[key] = number
            //print (potential_pairs)
            //print (pairings)
            //print ("")
        }
        ViewController.MyVariables.pairings = pairings
        //print (potential_pairs)
        //print (ViewController.MyVariables.pairings)
    }
    
    func openThanksView() {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Thanks") as! Thanks
        self.present(Controller, animated:false, completion:nil)
    }
}
