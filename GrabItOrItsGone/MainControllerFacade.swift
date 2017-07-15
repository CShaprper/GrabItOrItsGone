//
//  MainControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import AVFoundation

class MainControllerFacade: IFirebaseDataReceivedDelegate {
    //MARK:-Members
    private var audioplayer:AVAudioPlayer!
    private var presentingController:MainController!
    var productsArray:[ProductCard]!
    var firebaseClient:FirebaseClient!
    
    //Constructor
    init(presentingController: MainController) {
        self.presentingController = presentingController
        firebaseClient = FirebaseClient()
        firebaseClient.firebaseDataReceivedDelegate = self
        productsArray = []
    }
    
    //Audioplayer vorbereiten
    private func PrepareAudioPlayer(filename:String, filetype:String) -> Void {
            if let path = Bundle.main.path(forResource: filename, ofType: filetype){
                let url = URL(fileURLWithPath: path)
                audioplayer = try? AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
                audioplayer.prepareToPlay()
            }
    }
    private func AudioPlayerPlaySound(){
        let sound = UserDefaults.standard.bool(forKey: eUserDefaultKeys.SoundsOn.rawValue)
          if sound {
        audioplayer.play()
        }
    }
    
    func PlaySwooshSound() -> Void {
        PrepareAudioPlayer(filename: "swoosh", filetype: "wav")
        AudioPlayerPlaySound()
    }
    func PlayYeahSound() -> Void {
        PrepareAudioPlayer(filename: "yeah", filetype: "m4a")
        AudioPlayerPlaySound()
    }
    
    func LogoutFirebaseUser(){
        firebaseClient.LogoutAuthenticableUser()
    }
    
    func GetUserLoggedInService() -> eUserLoggedInService {
        let isLoggedInWithFacebook = UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInWithFacebook.rawValue)
        let isSignedInAsGuest = UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInAsGuest.rawValue)
        let isSignedInWithGoogle = UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInWithGoogle.rawValue)
        let isLoggedInWithInstagram = UserDefaults.standard.bool(forKey: eUserDefaultKeys.isLoggedInWithInstagram.rawValue)
        if isLoggedInWithFacebook {
            return eUserLoggedInService.facebook
        }
        if isSignedInWithGoogle {
            return eUserLoggedInService.google
        }
        if isSignedInAsGuest {
            return eUserLoggedInService.guest
        }
        if isLoggedInWithInstagram {
            return eUserLoggedInService.instagram
        } else {
            return eUserLoggedInService.email
        }
    }
    
    func SaveProductToFavorites(product: ProductCard){
        firebaseClient.SaveProductToFirebaseFavorites(product: product)
    }
    
    func CheckForSoundSetting(){
        if (UserDefaults.standard.object(forKey: eUserDefaultKeys.SoundsOn.rawValue) == nil) {
            UserDefaults.standard.set(false, forKey: eUserDefaultKeys.SoundsOn.rawValue)
        }
    }
    
    func FirebaseDataReceived() {
        //todo implement products data from Firebase Client
    }
}
