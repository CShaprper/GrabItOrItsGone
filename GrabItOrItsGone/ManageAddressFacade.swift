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
        Address.SaveAddress(address: address, context: context)
        addresses.append(address)
    }
    
    func FetchAdresses()->Void{
        addresses = Address.FetchAdresses(context: context)
       /* for a in addresses{
            print("City \(a.city) firstname \(a.firstname) lastname \(a.lastname) zip \(a.zipnumber) isShipment \(a.isDeliveryAddress)")
        }*/
    }

    func DeleteAddress(address: Address){
        Address.DeleteAddress(address: address, context: context)
    }
}
