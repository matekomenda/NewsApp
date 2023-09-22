//
//  GoogleLogin.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 21..
//

import SwiftUI
import GoogleSignIn
import UIKit
import Firebase
import FirebaseAuth

class GoogleAuthService: ObservableObject {
    @Published var googleUser = GoogleUser()
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            googleUser.update(with: user)
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)
                
        GIDSignIn.sharedInstance.configuration = config
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(
           withPresenting: presentingViewController
        )
        
        self.checkStatus()
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
