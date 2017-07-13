//
//  Address+CoreDataClass.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 12.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import CoreData


public class Address: NSManagedObject {
    static let EntityName = "Address"

    static func InsertIntoManagedObjectContext(context:NSManagedObjectContext)->Address{
        let obj = (NSEntityDescription.insertNewObject(forEntityName: Address.EntityName, into: context)) as! Address
        print("\(Address.EntityName) Entity object created in NSManagedObjectContext")
        return obj
    }
    
   static func SaveAddress(address:Address, context:NSManagedObjectContext) -> Void {
        do{
            try context.save()
            print("successfully saved \(address)")
        }
        catch let error as NSError{
            print(error.localizedDescription)
    }
    }
    
  static func FetchAdresses(context:NSManagedObjectContext) -> [Address] {
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Address.EntityName)
            let fetchResults = try context.fetch(fetchRequest) as? [Address]
            print("\(fetchResults!.count) \(Address.EntityName) objects fetched from Core Data")
            
            return fetchResults!
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return []
    }
}
