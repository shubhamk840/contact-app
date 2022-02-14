//
//  DatabaseOperations.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 11/02/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseOperations{
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static let Db = DatabaseOperations()
    private init(){
        
    }
    
    func add(firstName:String, secondName:String, contact:String, email:String, address:String, office:String){
        let currentContact = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: context! ) as! Contacts
        currentContact.fName = firstName
        currentContact.sName = secondName
        currentContact.contactNo = contact
        currentContact.emailId = email
        currentContact.address = address
        currentContact.officeCn = office
        do{
            try context?.save()
        }catch{
            print("Data is not saved")
        }
    }
    
    func delete(contact:String){
        
        let tempContact = contact as CVarArg
        let predicate = NSPredicate(format: "contactNo == %@", tempContact)
        let request = NSFetchRequest<Contacts>(entityName: "Contacts")
        request.predicate = predicate
        
        let fetchedList = try! context?.fetch(request)
        for name in fetchedList ?? []{
            context?.delete(name)
            do{
                try context?.save()
            }
            catch let error as NSError{
                print(error)
            }
        }
        
        CnContact.object.deleteContact(phone: contact)
        
        for (index,contacts) in listContacts.enumerated(){
            if(contacts.contact == contact ){
                listContacts.remove(at: index)
                break
            }
        }
        
    }
    
    func fetchEverything(){
        var fetchedContactList = [Contacts]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contacts")
        do{
            fetchedContactList = try context?.fetch(fetchRequest) as! [Contacts]
        }catch{
            print("Can not fetch data")
        }
        
        for contacts in fetchedContactList{
            
            if let firstName = contacts.fName, firstName.isEmpty == false,let secondName = contacts.sName , secondName.isEmpty == false,let contact = contacts.contactNo, contact.isEmpty == false, let office = contacts.officeCn, office.isEmpty == false, let address = contacts.address, address.isEmpty == false, let email = contacts.emailId, email.isEmpty == false{
                
                let object = ContactDetails(firstName: firstName, secondName: secondName, contact: contact, email: email, address: address, officeContact: office)
                listContacts.append(object)
            }
            
            
        }
    }
}


