//
//  ContactDetailsTableViewCell.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 11/02/22.
//

import UIKit

protocol editedData{
    func editedData(text:String,indexpath:Int)
}


class ContactDetailsTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var cellLabel: UILabel!
    
    var mydelegate: editedData?
    
    var indexpath: Int?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func editButton(_ sender: Any) {
        textField.isUserInteractionEnabled = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        if let data = textField.text, data.isEmpty == false,let indexpath = indexpath{
            self.mydelegate?.editedData(text: data,indexpath: indexpath)
        }        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let data = textField.text, data.isEmpty == false,let indexpath = indexpath{
            self.mydelegate?.editedData(text: data,indexpath: indexpath)
        }
    }
    
    
    
    
    
    
    
}
