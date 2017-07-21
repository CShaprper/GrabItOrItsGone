//
//  MainControllerFacade.swift
//  GrabItOrItsGone
//
//  Created by Peter Sypek on 13.07.17.
//  Copyright © 2017 Peter Sypek. All rights reserved.
//

import UIKit
import AVFoundation

class MainControllerFacade: IFirebaseWebService {
    //MARK:-Members
    var delegate: IFirebaseWebService?
    private var audioplayer:AVAudioPlayer!
    private var presentingController:MainController! 
    var firebaseClient:FirebaseClient!
    let appDel = UIApplication.shared.delegate as! AppDelegate 
    
    //Constructor
    init(presentingController: MainController) {
        self.presentingController = presentingController
        firebaseClient = FirebaseClient()
        firebaseClient.delegate = self
    }
    
    //MARK: - Audioplayer
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
    func FirebaseRequestFinished() { 
        if delegate != nil{
            delegate!.FirebaseRequestFinished!()
        }
    }
}
