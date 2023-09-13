//
//  ContentView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 12..
//

import SwiftUI

struct News: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct NewsSearchView: View {
    @State private var searchText = ""
    
    func fetchNews(searchQuery: String) {
        print("called")
        let urlString = "https://newsapi.org/v2/everything?q=\(searchQuery)&apiKey=2f5531e5be544560a63a024de1a60350"
        print(urlString)
    }
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: .pink, bottomColor: .white)
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
                        }
                }
                Spacer()
            }
        }
    }
}

struct AppTitle: View {
    var appTitle: String;
    
    var body: some View {
        Text(appTitle)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

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

struct NewsSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSearchView()
    }
}
