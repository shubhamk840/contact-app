//
//  ViewController.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 01/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
   }
    
   

    @IBAction func signup(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let adding_page = storyBoard.instantiateViewController(withIdentifier: "adding_page") as? SignInViewController{
        navigationController?.pushViewController(adding_page, animated: true);
        }
        
    }
    
    @IBAction func signin(_ sender: Any) {
        
        if let name = firstName.text , name.isEmpty == false ,let password = password.text, password.isEmpty == false{
            
                if(UserDefaults.standard.string(forKey: name) == password){
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if let list_view = storyBoard.instantiateViewController(withIdentifier: "list_view") as? ListViewController{
                        list_view.navigationItem.title = "Hi , \(name)"
                    navigationController?.pushViewController(list_view, animated: true);
                    }
                    
               }
                else{
                    
                        let alert = UIAlertController(title: "Sorry", message: "Either FirstName or Password is Incorrect", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                        
                        
                        self.present(alert,animated: true, completion: nil )
                    
                }
            }
        else{
            
            let alert = UIAlertController(title: "Message", message: "Please enter details correctly", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            
            
            self.present(alert,animated: true, completion: nil )
            
        }
        }
        
        
    }
    
    
    
    
    






