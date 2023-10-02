//
//  NewsApiApp.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 12..
//

import SwiftUI
import Firebase
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct NewsApiApp: App {
    @StateObject var appStore: AppStore = AppStore()
    @StateObject var googleAuthService: GoogleAuthService =  GoogleAuthService()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            NewsApp()
                .environmentObject(googleAuthService)
                .environmentObject(appStore)
        }
    }
}
