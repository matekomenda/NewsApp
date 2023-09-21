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
        VStack {
            NewsCard(article: article).navigationTitle("News Detail")
        }
    }
}

struct NewsDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(source: Source(name: "sourcename"), title: "title", description: "description", content: "content", publishedAt: "published at", url: "defaulto", urlToImage: "defaulto")
        return NewsDetailScreen(article: article)
    }
}
