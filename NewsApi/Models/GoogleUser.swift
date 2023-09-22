//
//  GoogleUser.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 21..
//

import Foundation
import SwiftUI
import GoogleSignIn

class GoogleUser: ObservableObject {
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var email: String = ""
    
    func update(with user: GIDGoogleUser) {
        let givenName = user.profile?.givenName ?? ""
        let email = user.profile?.email ?? ""
        let profilePicUrl = user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
        
        self.givenName = givenName
        self.email = email
        self.profilePicUrl = profilePicUrl
    }
}

