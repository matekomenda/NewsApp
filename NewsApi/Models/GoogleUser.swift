//
//  GoogleUser.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 21..
//

import Foundation
import SwiftUI

class GoogleUser: Identifiable, ObservableObject {
    public let id: UUID
    private var givenName: String
    private var profilePicUrl: String
    private var email: String
    
    
    init(id: UUID = UUID(), givenName: String, profilePicUrl: String, email: String) {
        self.id = id
        self.givenName = givenName
        self.profilePicUrl = profilePicUrl
        self.email = email
    }
    
    func getGivenName() -> String { return self.givenName }
    func setGivenName(givenName: String) -> Void {self.givenName = givenName }
    
    func getProfilePicUrl() -> String { return self.profilePicUrl }
    func setProfilePicUrl(profilePicUrl: String) -> Void {self.profilePicUrl = profilePicUrl }
    
    func getEmail() -> String { return self.email }
    func setEmail(email: String) -> Void {self.email = email }
    
}
