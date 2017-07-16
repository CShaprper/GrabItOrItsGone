//
//  ManageFavoritesFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class ManageFavoritesFacade: IFirebaseDataReceivedDelegate {
    //MARK: - Members
    var favoritesArray:[ProductCard]!
    var firebaseClient:FirebaseClient! 
    
    //Constructor
    init() {
        favoritesArray = []
        firebaseClient = FirebaseClient()
    }
    
    func ReadFirebaseFavoritesSection(){
        favoritesArray = []
        firebaseClient.ReadFirebaseFavoritesSection()
    }
    
    //MARK: - IFirebaseDataReceivedDelegate implementation
    func FirebaseDataReceived() {
        favoritesArray = firebaseClient.favoritesArray
    }
}
