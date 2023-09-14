//
//  AppTitle.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 13..
//

import Foundation
import SwiftUI

struct AppTitle: View {
    var appTitle: String;
    
    var body: some View {
        Text(appTitle)
            .font(.system(size: 32, weight: .medium, design: .default))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }
}
