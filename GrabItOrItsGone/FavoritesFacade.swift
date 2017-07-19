//
//  ManageFavoritesFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class FavoritesFacade {
    //MARK: - Members
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var firebaseClient:FirebaseClient!
    var favoritesArray:[ProductCard]{
        get {
            return appDel.favoritesArray
        }
        set {
            appDel.favoritesArray = newValue
        }
    }
    
    //Constructor
    init() {
        firebaseClient = FirebaseClient()
    }
    
    func ReadFirebaseFavoritesSection(){
        if appDel.favoritesArray.count == 0{
            firebaseClient.ReadFirebaseFavoritesSection()
        }
    }
    
    func DeleteFavoriteWithID(idToDelete: String){
        firebaseClient.DeleteProductFromFirebaseFavorites(idToDelete: idToDelete)
    }
}
