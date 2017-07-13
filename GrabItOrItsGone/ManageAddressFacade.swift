//
//  ManageAddressFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import UIKit

class ManageAddressFacade {
    //MARK:-Members
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var address:Address!
    var addresses:[Address]!
    
    init() {
        addresses = []
    }
    
    func CreateNewAddressToInsert() -> Void {
        address = Address.InsertIntoManagedObjectContext(context: context)
    }
    
    func SaveAddress() -> Void {
        address.SaveAddress(address: address)
    }
    
    func FetchAdresses()->Void{
        address = Address.InsertIntoManagedObjectContext(context: context)
       addresses = address.FetchAdresses()
    }

}
