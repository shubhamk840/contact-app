//
//  Validators.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 14/02/22.
//

import Foundation

class Validators{
    
    static let object = Validators()
    
    private init(){
        
    }
    
    func validateEmail(YourEMailAddress: String) -> Bool {
        print(YourEMailAddress)
        if YourEMailAddress == ""{
            return true
        }
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    
    func validatePhone(value: String) -> Bool {
//                let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//                let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//                let result = phoneTest.evaluate(with: value)
//                return result
        return true
        
            }
}
