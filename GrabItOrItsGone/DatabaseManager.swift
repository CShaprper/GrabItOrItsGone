//
//  File.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 12.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
   private class func getContext() -> NSManagedObjectContext {
        let appDel = UIApplication.shared.delegate as! AppDelegate
    return appDel.persistentContainer.viewContext
    }
}
