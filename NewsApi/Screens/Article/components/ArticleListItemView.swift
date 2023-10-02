//
//  ArticleListItemView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 28..
//

import SwiftUI

struct ArticleListItemView: View {
    var article: FirebaseArticle
    
    private func deleteItem(at indexSet: IndexSet) {
        // self.d.remove(atOffsets: indexSet)
    }
    
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 90)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(width: 120, height: 90)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .bold()
                        .font(.subheadline)
                        .lineLimit(1)
                    Text(article.lead)
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }
            }
        }
    }
}




struct ArticleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListItemView(article: FirebaseArticle(
            id: "1", title: "title", lead: "test", description: "tst", imageUrl: "https://d.newsweek.com/en/full/2287157/elon-musk.jpg"
        ))
    }
}
