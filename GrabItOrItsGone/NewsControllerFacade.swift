//
//  NewsControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class NewsControllerFacade: IFirebaseDataReceivedDelegate {

    //MARK:-Members
    var alertMessateTitle: String?
    var alertMessageMessage: String?
    var newsArray:[News]!
    var firebaseClient:FirebaseClient!
    var firebaseDataReceivedDelegate:IFirebaseDataReceivedDelegate?
    
    //Constructor
    init(presentingController: NewsController) {
        firebaseClient = FirebaseClient() 
        firebaseClient.firebaseDataReceivedDelegate = self
        newsArray = []
    }
    
    //MARK: - IFirebaseDataReceivedDelegate implementation
    func ReadFirebaseNewsSection() -> Void {
        firebaseClient.ReadFirebaseNewsSection()
    }
    
    func FirebaseDataReceived() -> Void {
       if firebaseDataReceivedDelegate != nil{
            newsArray = firebaseClient.newsArray
            firebaseDataReceivedDelegate!.FirebaseDataReceived()
        }
    }
}
