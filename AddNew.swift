//
//  AddNew.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/6/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit

class AddNew: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var Group_Name: UITextField!
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Date_Picker: UIDatePicker!
    @IBOutlet weak var Next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Date_Picker.minimumDate = Date()
        Group_Name.becomeFirstResponder()
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Makes the touch not interfere and cancel other interactions
        //tap.cancelsTouchesInView = false
        //view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are sure you want to go back?", message: "If you continue, all selections will be cleared.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: { action in
            self.Cancel()
        }))
        alert.addAction(UIAlertAction(title: "Stay here", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func Cancel() {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.present(Controller, animated:false, completion:nil)
        
        //Clear all existing data
        ViewController.MyVariables.group_name = ""
        ViewController.MyVariables.bad_pairings = [:]
        ViewController.MyVariables.people = [:]
        ViewController.MyVariables.pairings = [:]
        ViewController.MyVariables.exchange_date = ""
        ViewController.MyVariables.price_limit = ""
        ViewController.MyVariables.location = ""
        ViewController.MyVariables.detailed_pairings = [:]
    }
    
    @IBAction func Next(_ sender: Any) {
        if Group_Name.text == "" {
            let alert = UIAlertController(title: "Name your group", message: "Please give your group a name before continuing", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else if Location.text == "" {
            let alert = UIAlertController(title: "No location entered", message: "Please specify a location before continuing", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else {
            ViewController.MyVariables.group_name = Group_Name.text ?? ""
            ViewController.MyVariables.location = Location.text ?? ""
            
            //print (ViewController.MyVariables.group_name)
            Date_Picker.datePickerMode = UIDatePicker.Mode.date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "MMMM dd yyyy"
            let selectedDate = dateFormatter.string(from: Date_Picker.date)
            print(selectedDate)
            ViewController.MyVariables.exchange_date = selectedDate
            let Controller = storyboard?.instantiateViewController(withIdentifier: "AddPeople") as! AddPeople
            
            self.present(Controller, animated:false, completion:nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("Working")
        textField.resignFirstResponder()
        if textField == Group_Name {
            Location.becomeFirstResponder()
        }
        //Next(Group_Name)
        return true
    }

    func dismissKeyboard() {
        //self.view.endEditing(true)
    }
    
}
