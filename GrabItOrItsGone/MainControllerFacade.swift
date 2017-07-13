//
//  MainControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import Foundation
import AVFoundation

enum eUserLoggedInService{
    case facebook
    case google
    case email
    case guest
}

class MainControllerFacade: IFirebaseDataReceivedDelegate {
    //MARK:-Members
    private var audioplayer:AVAudioPlayer!
    private var presentingController:MainController!
    private var alertService:IAlertMessage!
    var productsArray:[ProductCard]!
    var firebaseClient:FirebaseClient!
    var firebaseDataReceivedDelegate:IFirebaseDataReceivedDelegate?
    
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
        let sound = UserDefaults.standard.bool(forKey: "SoundsOn")
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
        let isLoggedInWithFacebook = UserDefaults.standard.bool(forKey: "isLoggedInWithFacebook")
        let isSignedInAsGuest = UserDefaults.standard.bool(forKey: "isLoggedInAsGuest")
        let isSignedInWithGoogle = UserDefaults.standard.bool(forKey: "isLoggedInWithGoogle")
        if isLoggedInWithFacebook {
            return eUserLoggedInService.facebook
        }
        if isSignedInWithGoogle {
            return eUserLoggedInService.google
        }
        if isSignedInAsGuest {
            return eUserLoggedInService.guest
        } else {
            return eUserLoggedInService.email
        }
    }
    
    func CheckForSoundSetting(){
        if (UserDefaults.standard.object(forKey: "SoundOn") == nil) {
            UserDefaults.standard.set(false, forKey: "SoundOn")
        }
    }
}
