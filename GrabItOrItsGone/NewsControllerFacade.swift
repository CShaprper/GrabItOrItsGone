//
//  NewsControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class NewsControllerFacade {
    //MARK:-Members 
    var firebaseClient:FirebaseClient!
    var newsArray:[News]{
        get {
            return firebaseClient.newsArray
        }
        set {
            firebaseClient.newsArray = newValue
        }
    }
    
    //Constructor
    init(presentingController: NewsController) {
        firebaseClient = FirebaseClient()  
    }
    
    //MARK: - IFirebaseDataReceivedDelegate implementation
    func ReadFirebaseNewsSection() -> Void {
        firebaseClient.ReadFirebaseNewsSection()
    }
}
