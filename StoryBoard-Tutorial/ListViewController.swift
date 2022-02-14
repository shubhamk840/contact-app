//
//  ListViewController.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 04/02/22.
//

import UIKit
import CoreData


class ListViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    
    @IBAction func addButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Contact_Details = storyBoard.instantiateViewController(withIdentifier: "Contact_Details") as! ContactDetailsViewController
        self.navigationController?.pushViewController(Contact_Details, animated: true)
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searching = false
    
    var filterData = [ContactDetails]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        filterData = listContacts
        listContacts.sort(by: {
            return  $0.firstName.uppercased() < $1.firstName.uppercased()
        })
        super.viewWillAppear(animated)
        self.listCollectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        configureSearchController()
        // Do any additional setup after loading the view.
        
    }
    
    func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search By Name"
    }
    
    
}


extension ListViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            filterData.removeAll()
            for data in listContacts{
                if(data.firstName.lowercased().contains(searchText.lowercased())){
                    filterData.append(data)
                }
            }
        }
        else{
            searching = false
            filterData.removeAll()
            filterData = listContacts
        }
        listCollectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(listContacts.count)
        if searching{
            return filterData.count
        }
        else{
            return listContacts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListCollectionViewCell
        
        
        //        cell.contentView.backgroundColor = UIColor(red: redValue,green : greenValue, blue: blueValue, alpha: alphaValue)
        
        if searching{
            
            cell.name.text = filterData[indexPath.row].firstName + " " + filterData[indexPath.row].secondName
            
            let firstName = filterData[indexPath.row].firstName
            let secondName = filterData[indexPath.row].secondName
            
            cell.roundLabel.text = firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1)).uppercased() + secondName.substring(to:secondName.index(secondName.startIndex, offsetBy: 1)).uppercased()
            
            
        }
        else{
            //            print(redValue,greenValue,blueValue,alphaValue)
            cell.name.text = listContacts[indexPath.row].firstName + " " + listContacts[indexPath.row].secondName
            let firstName = listContacts[indexPath.row].firstName
            let secondName = listContacts[indexPath.row].secondName
            cell.roundLabel.text = firstName.substring(to: firstName.index(firstName.startIndex, offsetBy: 1)).uppercased() + secondName.substring(to:secondName.index(secondName.startIndex, offsetBy: 1)).uppercased()
            
        }
        
        cell.viewDetails.tag = indexPath.row
        cell.viewDetails.addTarget(self, action: #selector(viewDetail), for: .touchUpInside)
        
        cell.roundLabel.layer.masksToBounds = true
        cell.roundLabel.layer.cornerRadius = 60
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Contact_Details = storyBoard.instantiateViewController(withIdentifier: "Contact_Details") as! ContactDetailsViewController
        if searching{
            Contact_Details.currentDetails = filterData[indexPath.row]
        }
        else{
            Contact_Details.currentDetails = listContacts[indexPath.row]
        }
        self.navigationController?.pushViewController(Contact_Details, animated: true)
    }
    
    @objc func viewDetail(sender:UIButton){
        
        
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            if(self.searching){
                let tempContact = self.filterData[indexpath1.row].contact
                self.filterData.remove(at: indexpath1.row)
                DatabaseOperations.Db.delete(contact:tempContact)
            }
            else{
                let tempContact = listContacts[indexpath1.row].contact
                DatabaseOperations.Db.delete(contact:tempContact)
                
            }
            self.listCollectionView.reloadData()
            
            
        }))
        
        alert.addAction(UIAlertAction(title:"Cancel",style: .default,handler:nil))
        
        self.present(alert,animated: true, completion: nil)
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-10)/2, height: (collectionView.frame.width-10)/2)
    }
    
    
    
}

