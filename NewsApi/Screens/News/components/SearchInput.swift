//
//  SearchInput.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 15..
//

import Foundation
import SwiftUI

enum NewsApiError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct SearchInput: View {
    @State private var searchText = ""
    @State private var errorMessage: String? = nil
    @Binding var articles: [Article]
    @Binding var isSearchingHappened: Bool
    @Binding var isLoading: Bool
    
    init(articles: Binding<[Article]>, isSearchingHappened: Binding<Bool>, isLoading: Binding<Bool>) {
        _articles = articles
        _isSearchingHappened = isSearchingHappened
        _isLoading = isLoading
    }
    
    func handleSearch() {
        if searchText.count < 3 {
            isSearchingHappened = false
            errorMessage = "Please write at least 3 characters for searching."
        } else {
            Task {
                defer {
                    isLoading = false
                }
                do {
                    isSearchingHappened = true
                    isLoading = true
                    try await fetchNews(searchQuery: searchText)
                    errorMessage = nil
                } catch {
                    print("Error fetching news: \(error)")
                    errorMessage = "Error fetching news. Please try again later."
                }
            }
        }
    }
    
    func fetchNews (searchQuery: String) async throws {
        let searchQueryWithoutWhitespaces = searchQuery.replacingOccurrences(of: " ", with: "")
        let endpoint = "https://newsapi.org/v2/everything?q=\(searchQueryWithoutWhitespaces)&apiKey=2f5531e5be544560a63a024de1a60350"
        

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
        } catch let decodingError {
            print("Decoding error: \(decodingError)")
            throw NewsApiError.invalidData
        }
    }
    
    var body: some View {
            ZStack(alignment: .trailing) {
                TextField("Search", text: $searchText)
                    .padding(.horizontal, 10)
                    .font(.system(size: 24))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
                    .onSubmit {
                        handleSearch()
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                    .padding(.trailing, 10)
                }
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.system(size: 14))
                    .foregroundColor(Color.red)
                    .padding(.top, 5)
            }
        }
}
