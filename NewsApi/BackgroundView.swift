//
//  BackgroundView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 13..
//

import Foundation
import SwiftUI


struct BackgroundView: View {
    var topColor: Color;
    var bottomColor: Color;
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint:.topLeading,
                       endPoint: .bottomLeading)
        .edgesIgnoringSafeArea(.all)
    }
}
