//
//  Address+CoreDataProperties.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 12.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var firstname: String?
    @NSManaged public var houseneumber: String?
    @NSManaged public var isDeliveryAddress: Bool
    @NSManaged public var lastname: String?
    @NSManaged public var streetname: String?
    @NSManaged public var zipnumber: String?

}
