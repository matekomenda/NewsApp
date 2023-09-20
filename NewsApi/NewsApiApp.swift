//
//  NewsApiApp.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 12..
//

import SwiftUI

@main
struct NewsApiApp: App {
    let appStore = AppStore()
    
    var body: some Scene {
        WindowGroup {
            NewsApp()
                .environmentObject(appStore)
        }
    }
}
