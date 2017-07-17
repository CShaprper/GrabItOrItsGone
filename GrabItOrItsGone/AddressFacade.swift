//
//  ManageAddressFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import UIKit

class AddressFacade{
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
    }

    func DeleteAddress(address: Address){
        Address.DeleteAddress(address: address, context: context)
    }
  
    func ValidateUserInput(segmentedControl: UISegmentedControl) -> Bool{
        var isValid: Bool
        ValidationFactory.segmentedControl = segmentedControl
        isValid = ValidationFactory.Validate(type: .segmentedControl, validationString: nil)
        isValid = ValidationFactory.Validate(type: .textField, validationString: address.firstname)
        isValid = ValidationFactory.Validate(type: .textField, validationString: address.lastname)
        isValid = ValidationFactory.Validate(type: .textField, validationString: address.streetname)
        isValid = ValidationFactory.Validate(type: .textField, validationString: address.city)
        isValid = ValidationFactory.Validate(type: .zipCode, validationString: address.zipnumber)
        return isValid
    }
}
