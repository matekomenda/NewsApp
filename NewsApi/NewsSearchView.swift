//
//  ContentView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 12..
//

import SwiftUI

enum NewsApiError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
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

struct APIResponse: Codable {
    let articles: [Article]
}

struct Source: Codable {
    let name: String
}

struct NewsSearchView: View {
    @State private var searchText = ""
    @State private var articles: [Article] = []
    
    func fetchNews (searchQuery: String) async throws {
        let endpoint = "https://newsapi.org/v2/everything?q=\(searchQuery)&apiKey=2f5531e5be544560a63a024de1a60350"
        

        guard let myUrl = URL(string: endpoint) else {
            throw NewsApiError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: myUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsApiError.invalidResponse
        }
        do {
            let result = try JSONDecoder().decode(APIResponse.self, from: data)
            print(result.articles.count)
            articles = result.articles
            print(articles)
            // print(result.articles)
        } catch let decodingError {
            print("Decoding error: \(decodingError)")
            throw NewsApiError.invalidData
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(topColor: .pink, bottomColor: .white).zIndex(0)
                VStack {
                    AppTitle(appTitle: "News App")
                    Spacer().frame(height: 75)
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(.horizontal, 10)
                            .font(.system(size: 24))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onSubmit {
                                print("Entered text: \(searchText)")
                                Task{
                                    do {
                                        try await fetchNews(searchQuery: searchText)
                                    } catch {
                                        print("Error fetching news: \(error)")
                                    }
                                }
                            }
                    }
                    Spacer()
                    List(articles, id: \.title) { article in
                        NavigationLink(destination: Text("Detail view for \(article.title)")) {
                                NewsCard(article: article)
                            }
                    }
                }
            }
        }.navigationTitle("News")
    }
}

/*struct NewsCard: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.headline)
            if let description = article.description {
                Text(description)
                    .font(.subheadline)
            } else {
                Text("No description available") // or some default text
            }
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}*/
struct NewsCard: View {
    let article: Article

    var body: some View {
        HStack {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl), let data = try? Data(contentsOf: url) {
                Image(uiImage: UIImage(data: data) ?? UIImage())
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)

                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                } else {
                    Text("No description available") // or some default text
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}


struct NewsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSearchView()
    }
}
