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
            AsyncImage(url: URL(string: googleAuthService.googleUser.profilePicUrl))
                // .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
    }
}

struct RoundedProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedProfilePictureView()
    }
}
