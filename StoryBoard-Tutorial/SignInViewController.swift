//
//  SignInViewController.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 02/02/22.
//

import UIKit

// creating an array

var listContacts = [ContactDetails]()


class ContactDetails{
    var firstName:String
    var secondName:String
    var contact:String
    var email:String
    var address:String
    var officeContact:String
    
    init(firstName: String , secondName: String, contact: String,email:String,address:String,officeContact:String){
        self.firstName = firstName
        self.secondName = secondName
        self.contact = contact
        self.email = email
        self.address = address
        self.officeContact = officeContact
    }
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmedPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        contact.delegate = self
        secondName.delegate = self
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        if let firstName = firstName.text, firstName.isEmpty == false,let secondName = secondName.text , secondName.isEmpty == false,let contact = contact.text, contact.isEmpty == false,let pass = password.text, pass.isEmpty == false,let confirmPass = confirmedPassword.text, confirmPass.isEmpty == false{
            
            if(UserDefaults.standard.string(forKey: firstName) != nil){
                Alerts.object.pushAlerts(title: "Message", message: "Username not available", optionTitle: "OK", controller: self)
            }
            else{
                if(pass == confirmPass){
                    UserDefaults.standard.set(pass,forKey: firstName)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let list_view = storyBoard.instantiateViewController(withIdentifier: "list_view") as? ListViewController{
                        list_view.navigationItem.title = "Hi , \(firstName)"
                    navigationController?.pushViewController(list_view, animated: true);
                    Alerts.object.pushAlerts(title: "Message", message: "Username succesfully created", optionTitle: "OK", controller: self)
                    }
                }
                else{
                    Alerts.object.pushAlerts(title: "Sorry", message: "Password Do Not Match", optionTitle: "OK", controller: self)
                }
            }
        }
        
        else{
            Alerts.object.pushAlerts(title: "Sorry", message: "Fields Missing", optionTitle: "OK", controller: self)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contact.resignFirstResponder()
    }
}

extension SignInViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


