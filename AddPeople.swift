//
//  AddPeople.swift
//  Better Secret Santa
//
//  Created by Cooper Garren on 12/6/18.
//  Copyright © 2018 Cooper Garren. All rights reserved.
//

import UIKit
import ContactsUI

class AddPeople: UIViewController, CNContactPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    var contactStore = CNContactStore()
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .denied, .notDetermined:
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
            })
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ViewController.MyVariables.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"/*Identifier*/, for: indexPath)
        cell.textLabel?.text = ViewController.MyVariables.people[indexPath[1]]?[0]
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Next: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        Name.text = ViewController.MyVariables.group_name
        if ViewController.MyVariables.people.count >= 2 {
            Next.isEnabled = true
        }
    }
    
    func viewWillAppear() {
        tableView.reloadData()
    }
    
    func onClickPickContact(){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys =
            [CNContactGivenNameKey
                , CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController,
                       didSelect contactProperty: CNContactProperty) {
    }
    
    //Need an exception if contact is already added
    //Gray out the next button until a nam eis entered
    //Clear all selections upon going back to start screen
    //SHOW ALERT before cenceling selections
    //Make it so that two people can't select each other to not buy for
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let userName:String = contact.givenName
        let familyName: String = contact.familyName
        
        let phoneNumberCount = contact.phoneNumbers.count
        
        guard phoneNumberCount > 0 else {
            dismiss(animated: true)
            let alert = UIAlertController(title: "No phone number", message: "There is no phone number associated with that contact.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        //print(contact.phoneNumbers)
        //print(userPhoneNumbers[0].value)
        let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value
        
        // user phone number
        let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue
        //print(primaryPhoneNumberStr)
        
        var existsAlready = false
        
        for (key, value) in ViewController.MyVariables.people {
            //print (value[0])
            if value[0] == userName + " " + familyName {
                existsAlready = true
            }
        }
        
        if existsAlready == false {
            ViewController.MyVariables.people[ViewController.MyVariables.people.count] = [userName + " " + familyName, primaryPhoneNumberStr]
        } else {
            dismiss(animated: true)
            let alert = UIAlertController(title: "Person already added", message: userName + " " + familyName + " already exists in the group.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        //print(ViewController.MyVariables.people)
        
        tableView.reloadData()
        
        if ViewController.MyVariables.people.count >= 2 {
            Next.isEnabled = true
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        if ViewController.MyVariables.people.count >= 2 {
            Next.isEnabled = true
        }
    }
    
    @IBAction func Back(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "AddNew") as! AddNew
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func Next(_ sender: Any) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Options") as! Options
        self.present(Controller, animated:false, completion:nil)
    }
    
    @IBAction func AddByEmail(_ sender: UIButton) {
        let Controller = storyboard?.instantiateViewController(withIdentifier: "Email") as! Email
        
        self.present(Controller, animated:true, completion:nil)
    }
    
    @IBAction func AddByContact(_ sender: UIButton) {
        onClickPickContact()
    }
}
