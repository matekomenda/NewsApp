//
//  MenuView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 20..
//

import Foundation
import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        VStack {
            Text("Username: YourUsername")
            Text("Email: your.email@example.com")
            Button(action: {
                // Handle logout action here
                appStore.isMenuOpen.toggle()
            }) {
                Text("Logout")
            }
            .padding(.top, 20)
        }
        .frame(width: 200, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
}
