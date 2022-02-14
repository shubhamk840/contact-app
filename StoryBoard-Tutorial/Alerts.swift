//
//  Alerts.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 13/02/22.
//

import Foundation
import UIKit

class Alerts {
    
    static let object = Alerts()
    
    private init(){
        
    }
    
    
    func pushAlerts(title:String,message:String,optionTitle:String,controller:UIViewController){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: optionTitle, style: .default, handler:nil))
        
        
        controller.present(alert,animated: true, completion: nil )       
    }
}
