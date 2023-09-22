//
//  RoundedProfilePictureView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 22..
//

import SwiftUI

struct RoundedProfilePictureView: View {
    @EnvironmentObject var googleAuthService: GoogleAuthService
    
    var body: some View {
        if googleAuthService.isLoggedIn {
            AsyncImage(url: URL(string: googleAuthService.googleUser.profilePicUrl))
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("ProfilePictureBorderColor"), lineWidth: 5))
                .padding(.bottom, 20)
                .onTapGesture {
                    // todo
                }
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(Color.gray)
                .clipShape(Circle())
                .onTapGesture {
                    // Handle tap action (e.g., show the login screen)
                }
        }
    }
}

struct RoundedProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedProfilePictureView()
    }
}
