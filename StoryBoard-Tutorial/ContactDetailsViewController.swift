//
//  ContactDetailsViewController.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 08/02/22.
//

import UIKit
import CoreData


class ContactDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,editedData {
    
    @IBOutlet weak var saveButton: UIButton!
    var firstName:String?
    var secondName:String?
    var contact:String?
    var address:String = ""
    var office:String = ""
    var email:String = ""
    
    var showEdit:Bool = true
    var flag:Bool = true
    
    @objc func editclickButton(){
        flag = true
        self.myTable.reloadData()
        
    }
    
    
    
    
    
    
    func editedData(text: String, indexpath: Int) {
        
        if(indexpath == 0){
            
            firstName = text
        }
        else if(indexpath == 1){
            
            secondName = text
        }
        else if(indexpath == 2){
            
            contact = text
        }
        else if(indexpath == 3){
            
            office = text
        }
        else if(indexpath == 4){
            
            email = text
        }
        else if(indexpath == 5){
            
            address = text
        }
    }
    
    
    
    
    
    
    
    @IBOutlet weak var myTable: UITableView!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onUploadButtonClick(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker,animated: true,completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        imageView.image = info[.originalImage] as? UIImage
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var currentDetails:ContactDetails?
    
    
    
    override func viewDidLoad() {
        
        
        if(currentDetails?.officeContact == nil){
            showEdit = false
        }
        firstName = currentDetails?.firstName
        secondName = currentDetails?.secondName
        contact = currentDetails?.contact
        office = currentDetails?.officeContact ?? ""
        email = currentDetails?.email ?? ""
        address = currentDetails?.address ?? ""
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        let testUIBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.editclickButton))
        if(showEdit == true){
            flag = false
            saveButton.setTitle("Update", for: .normal)
            self.navigationItem.rightBarButtonItem = testUIBarButtonItem
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactDetailsTableViewCell
        cell.indexpath = indexPath.row
        
        cell.textField.backgroundColor = .systemGray6
        
        if flag == true{
            cell.textField.backgroundColor = .white
        }
        
        cell.textField.isUserInteractionEnabled = flag
        
        
        cell.mydelegate = self
        
        if(indexPath.row == 0){
            cell.textField.text = firstName  ?? currentDetails?.firstName
            
            cell.cellLabel.text = "First Name"
            
        }
        else if(indexPath.row == 1){
            cell.textField.text = secondName ?? currentDetails?.secondName
            
            cell.cellLabel.text = "Second Name"
            
            
        }
        else if(indexPath.row == 2){
            cell.textField.text = contact == " " ?  currentDetails?.contact : contact
            cell.cellLabel.text = "Contact"
            
            
        }
        else if(indexPath.row == 3){
            cell.textField.text = office == ""  ? currentDetails?.officeContact : office
            cell.cellLabel.text = "Office"
            
            
        }
        else if(indexPath.row == 4){
            cell.textField.text = email == "" ? currentDetails?.email : email
          
            cell.cellLabel.text = "Email"
            
        }
        else if(indexPath.row == 5){
            cell.textField.text = address == "" ? currentDetails?.address : address
           
            cell.cellLabel.text = "Address"
            
            
        }
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        
        
        
        
        if(currentDetails?.contact != nil){
            
            DatabaseOperations.Db.delete(contact: currentDetails!.contact)
            
            
            CnContact.object.deleteContact(phone: currentDetails?.contact ?? " ")
            
            for (index,contacts) in listContacts.enumerated(){
                if(contacts.contact == currentDetails?.contact ){
                    listContacts.remove(at: index)
                    break
                }
            }
            
        }
        
        
        
        
        if let firstName = firstName, firstName.isEmpty == false,let secondName = secondName , secondName.isEmpty == false,let contact = contact, contact.isEmpty == false, Validators.object.validateEmail(YourEMailAddress: email) == true, Validators.object.validatePhone(value: contact) == true{
            
            let object = ContactDetails(firstName: firstName, secondName: secondName, contact: contact, email: email, address: address, officeContact: office)
            listContacts.append(object)
            
            CnContact.object.add(firstName: firstName, secondName: secondName, contact: contact, address: address, email: email, office: office)
            
            //            DatabaseOperations.Db.add(firstName: firstName, secondName: secondName, contact: contact, email: email, address: address, office: office)
            
            
            
            
        }
        else{
            
            if Validators.object.validateEmail(YourEMailAddress: email) == false{
                Alerts.object.pushAlerts(title: "Sorry", message: "Please enter correct email address", optionTitle: "OK", controller: self)
            }
            if let contact = contact, Validators.object.validatePhone(value: contact) == false{
                Alerts.object.pushAlerts(title: "Sorry", message: "Please enter correct phone number", optionTitle: "OK", controller: self)
            }
        }
        
        
        
        if let navController = self.navigationController{
            navController.popViewController(animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
}
