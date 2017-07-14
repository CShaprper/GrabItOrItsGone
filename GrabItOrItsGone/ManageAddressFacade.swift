//
//  ManageAddressFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import UIKit

class ManageAddressFacade{
    //MARK:-Members 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var address:Address!
    var addresses:[Address]!
    var textfieldInputValidationService:TextfieldInputValidationService?
    var segmentedControlValidationService:SegmentedControlValidationService?
    
    init() {
        addresses = []
        textfieldInputValidationService = TextfieldInputValidationService()
        segmentedControlValidationService = SegmentedControlValidationService()
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
  
    func ValidateUserTextfieldInput() -> Bool{
        if !textfieldInputValidationService!.Validate(validationString: address.firstname) || !textfieldInputValidationService!.Validate(validationString: address.lastname) || !textfieldInputValidationService!.Validate(validationString: address.streetname) || !textfieldInputValidationService!.Validate(validationString: address.city) ||
        !textfieldInputValidationService!.Validate(validationString: address.zipnumber){
            return false
        }
        return true
    }
    
    func ValidateUserInput_SegmentedtControl(control: UISegmentedControl) -> Bool {
        if !segmentedControlValidationService!.Validate(segmentedControl: control){
            return false
        }
        return true
    }
}
