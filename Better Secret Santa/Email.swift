//
//  Email.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/6/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class Email: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Contact_Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Contact_Name.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Cancel(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "AddPeople") as! AddPeople
        
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Add(_ sender: Any) {
        ViewController.MyVariables.people[ViewController.MyVariables.people.count] = [Contact_Name.text, Email.text] as? [String]
        
        let Controller = storyboard?.instantiateViewController(withIdentifier: "AddPeople") as! AddPeople
        
        self.present(Controller, animated:false, completion:nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField == Email) {
            Add(textField)
        }
        return true
    }
    
}
