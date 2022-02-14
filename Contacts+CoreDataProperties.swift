//
//  Contacts+CoreDataProperties.swift
//  StoryBoard-Tutorial
//
//  Created by Shubham on 13/02/22.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var contactNo: String?
    @NSManaged public var emailId: String?
    @NSManaged public var fName: String?
    @NSManaged public var sName: String?
    @NSManaged public var address: String?
    @NSManaged public var officeCn: String?

}

extension Contacts : Identifiable {

}
