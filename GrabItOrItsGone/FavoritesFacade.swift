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
    var favoritesArray:[ProductCard]{
        get {
            return firebaseClient.favoritesArray
        }
        set {
            firebaseClient.favoritesArray = newValue
        }
    }
    var firebaseClient:FirebaseClient! 
    
    //Constructor
    init() {
        firebaseClient = FirebaseClient()
    }
    
    func ReadFirebaseFavoritesSection(){
        firebaseClient.ReadFirebaseFavoritesSection()
    }
    
    func DeleteFavoriteWithID(idToDelete: String){
        firebaseClient.DeleteProductFromFirebaseFavorites(idToDelete: idToDelete)
    }
}
