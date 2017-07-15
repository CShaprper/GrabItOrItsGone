//
//  FavoritesDetailControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 15.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation

class FavoritesDetailControllerFacade {
    //MARK: - Members
    var firebaseClient:FirebaseClient!
    
    //Constructor
    init() {
        firebaseClient = FirebaseClient()
    }
}
