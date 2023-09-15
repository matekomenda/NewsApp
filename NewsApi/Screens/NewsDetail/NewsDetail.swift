//
//  NewsDetail.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 15..
//

import Foundation
import SwiftUI

struct NewsDetailScreen: View {
    let article: Article
    
    var body: some View {
        VStack{
            NewsCard(article: article).navigationTitle("News Detail")
        }
    }
}
