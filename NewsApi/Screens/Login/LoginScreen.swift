//
//  Login.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 20..
//

import SwiftUI
import GoogleSignInSwift

struct LoginScreen: View {
    @EnvironmentObject var googleLogin: GoogleLogin
    
    func handleSignInButton() {
        print("Hello google")
    }
    
    var body: some View {
        ZStack {
            VStack {
                if googleLogin.isLoggedIn {
                    VStack {
                        Spacer()
                        Text("Hello, \(googleLogin.givenName) again, good to see!")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Spacer()
                        AsyncImage(url: URL(string: googleLogin.profilePicUrl))
                            .frame(width: 250, height: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("ProfilePictureBorderColor"), lineWidth: 5))
                            .padding(.bottom, 20)
                        Spacer()
                        Button(action: {
                            googleLogin.signOut()
                        }) {
                            HStack {
                                Image(systemName: "arrow.turn.up.left.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color("GoogleBlue"))
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Hello, You can use Google Auth to login.")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Spacer()
                        GoogleSignInButton(action: {
                            googleLogin.signIn()
                        })
                        .padding(.top, 20)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
