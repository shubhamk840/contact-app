//
//  CnContact.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 13/02/22.
//

import Foundation
import Contacts

class CnContact{
    
    
    static let object = CnContact()
    
    private init(){
        
    }
    
    let store = CNContactStore()
    
    
    func fetchContacts(){
        print("Attempting to fetch contacts today")
        
        store.requestAccess(for: .contacts) { [self] granted, err in
            if let err = err{
                print("Failed to request access",err)
                return
            }
            
            let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey,
            CNContactOrganizationNameKey]
            
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            do{
                try self.store.enumerateContacts(with: request, usingBlock: {
                    (contact, stopEnumerating) in
                    let temp = ContactDetails(firstName: contact.givenName, secondName: contact.familyName, contact: contact.phoneNumbers.first?.value.stringValue ?? " ", email: (contact.emailAddresses.first?.value ?? " ") as String, address: contact.postalAddresses.count > 0 ? contact.postalAddresses[0].value.street : " ", officeContact: contact.organizationName)
                    listContacts.append(temp)
                    
                })
            }
            catch{
                
            }
            
            if granted{
                print("Access granted")
                
                
            }
            
        }
    }
    
    func deleteContact(phone:String){
        store.requestAccess(for: .contacts) { [self] granted, err in
            if let err = err{
                print("Failed to request access",err)
                return
            }
            
            let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey]
            
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            do{
                try self.store.enumerateContacts(with: request, usingBlock: {
                    (contact, stopEnumerating) in
          
                    if(phone == contact.phoneNumbers.first?.value.stringValue ?? " "){
                    let req = CNSaveRequest()
                    let mutable = contact.mutableCopy() as! CNMutableContact
                    req.delete(mutable)
                        do{
                            try store.execute(req)
                        }
                        catch let e{
                            print(e)
                        }
                    
                    }
                    
                })
            }
            catch{
                
            }
            
            if granted{
                print("Access granted")
            }
        }
    }
    
    func add(firstName:String,secondName:String,contact:String,address:String,email:String,office:String){
        let con = CNMutableContact()
        con.givenName = firstName
        con.familyName = secondName
        con.phoneNumbers.append(CNLabeledValue(label: "PhoneNumber", value: CNPhoneNumber(stringValue: contact)))
        con.organizationName = office
        let workemail = CNLabeledValue(label: "Email", value: email as NSString)
        con.emailAddresses = [workemail]
        let cnaddress = CNMutablePostalAddress()
        cnaddress.street = address
        let home = CNLabeledValue<CNPostalAddress>(label: CNLabelHome, value: cnaddress)
        con.postalAddresses = [home]
        let req = CNSaveRequest()
        req.add(con, toContainerWithIdentifier: nil)
        do{
        try store.execute(req)
        }
        catch let err{
            print(err ,"couldn't save it")
        }
    }
    
    
    
}
