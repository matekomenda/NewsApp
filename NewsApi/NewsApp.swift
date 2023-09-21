//
//  NewsApp.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 12..
//

import SwiftUI

struct NewsApp: View {
    @EnvironmentObject var googleLogin: GoogleLogin
    @State private var selectedTab: Tab = .login
    
    enum Tab {
        case login
        case logout
        case home
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            if googleLogin.isLoggedIn {
                LoginScreen()
                    .tabItem {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right.fill")
                    }
                    .tag(Tab.logout)
            } else {
                LoginScreen()
                    .tabItem {
                        Label("Login", systemImage: "person.fill")
                    }
                    .tag(Tab.login)
            }
            NewsScreen()
                .tabItem {
                    Label("News", systemImage: "house.fill")
                }
                .tag(Tab.home)
        }
    }
}

struct NewsApp_Previews: PreviewProvider {
    static var previews: some View {
        NewsApp()
    }
}
