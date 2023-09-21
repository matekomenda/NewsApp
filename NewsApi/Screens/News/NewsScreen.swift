//
//  NewsScreen.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 15..
//

import Foundation
import SwiftUI

struct Source: Codable {
    let name: String
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let content: String
    let publishedAt: String
    let url: String?
    let urlToImage: String?
}

struct NewsScreen: View {
    @State private var articles: [Article] = []
    @State private var isSearchingHappened: Bool = false
    @State private var isLoading: Bool = false
    @EnvironmentObject private var appStore: AppStore
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(topColor: .gray, bottomColor: Color.black).zIndex(0)
                VStack {
                    Spacer().frame(height: 25)
                    VStack {
                        SearchInput(articles: $articles, isSearchingHappened: $isSearchingHappened, isLoading: $isLoading)
                    }
                    Spacer()
                    if isLoading {
                        ProgressView("Fetching news...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.bottom, 50)
                    } else if articles.isEmpty && isSearchingHappened {
                        Text("No results found.")
                            .font(.headline)
                            .padding(.top, 20)
                    } else {
                        List(articles, id: \.title) { article in
                            NavigationLink(destination: NewsDetailScreen(article: article)) {
                                Text(article.title)
                            }
                        }.listStyle(PlainListStyle()).foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("News Search")
            .foregroundColor(.black)
        }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
