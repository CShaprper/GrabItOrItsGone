//
//  NewsControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit

class NewsControllerFacade: IFirebaseDataReceivedDelegate, IAlertMessageDelegate {
    //MARK:-Members
    private var presentingController:UIViewController!
    private var alertService:IAlertMessage!
    var newsArray:[News]!
    var firebaseClient:FirebaseClient!
    var firebaseDataReceivedDelegate:IFirebaseDataReceivedDelegate?
    
    //Constructor
    init(presentingController: NewsController) {
        self.presentingController = presentingController
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
            firebaseDataReceivedDelegate!.FirebaseDataReceived!()
        }
    }
    
    
    func ShowAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        presentingController.present(alert, animated: true, completion: nil)
    }
}
