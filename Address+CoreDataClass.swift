//
//  Address+CoreDataClass.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 12.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import CoreData


public class Address: NSManagedObject, IAlertMessageDelegate {
    var alertMessageDelegate:IAlertMessageDelegate?
    
    func SaveAddress(address:Address, context: NSManagedObjectContext) -> Void {
        var newAddress = NSEntityDescription.insertNewObject(forEntityName: "Address", into: context)      
      
        
        do{
            try context.save()
            print("successfully saved \(newAddress)")
        }
        catch let error as NSError{
            print(error.localizedDescription)
            if alertMessageDelegate != nil {
                alertMessageDelegate!.ShowAlertMessage!(title: "SaveAddressError_TitleString".localized, message: "SaveAddressError_MessageString".localized)
            }
        }
    }
}
