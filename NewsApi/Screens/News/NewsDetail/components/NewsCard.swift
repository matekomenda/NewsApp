//
//  NewsCard.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 15..
//

import Foundation
import SwiftUI

struct NewsCard: View {
    let article: Article
    let maxTitleLength = 50
    
    var truncatedTitle: String {
         return String(article.title.prefix(maxTitleLength) + "...")
     }
       
    var description: String {
        if let descriptionText = article.description {
            return descriptionText
        } else {
            return "No description available"
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(width: .infinity, height: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: 200)

              Text(truncatedTitle)
                  .font(.title)
                  .bold()

              Text(description)
                  .font(.body)
                  .foregroundColor(.secondary)

              Text("Content:")
                     .font(.headline)
                     .foregroundColor(.primary)

              Text(article.content)
                     .font(.body)
                     .foregroundColor(.primary)
            
            Text("Published At: \(article.publishedAt)")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
            Spacer()
          }
          .padding()
          .navigationTitle("News Detail")
        }
    }
}
