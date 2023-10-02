//
//  ArticleDetailView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 28..
//

import SwiftUI

struct ArticleDetailView: View {
    var articleDetail: FirebaseArticle
    @ObservedObject var articleList: FirebaseArticleViewModel
    @State var editableArticle = FirebaseArticle.emptyNewFirebaseArticle
    
    let maxTitleLength = 50
    @State var isArticleEditViewEnabled = false
    
    var truncatedTitle: String {
         return String(articleDetail.title.prefix(maxTitleLength) + "...")
     }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: articleDetail.imageUrl)) { image in
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

                Text(articleDetail.lead)
                  .font(.body)
                  .foregroundColor(.secondary)

              Text("Content:")
                     .font(.headline)
                     .foregroundColor(.primary)

                Text(articleDetail.description)
                     .font(.body)
                     .foregroundColor(.primary)
            Spacer()
          }
          .padding()
          .navigationTitle("Article Detail")
          .toolbar {
              ToolbarItem() {
                  Button("Edit",action: {
                      isArticleEditViewEnabled = true
                      editableArticle = articleDetail
                  })
              }
          }
          .sheet(isPresented: $isArticleEditViewEnabled) {
              NavigationStack {
                  ArticleEditView(firebaseEditArticle: $editableArticle)
                      .navigationTitle("Create Article")
                      .toolbar {
                          ToolbarItem(placement: .cancellationAction) {
                              Button("Cancel") {
                                  isArticleEditViewEnabled = false
                              }
                          }
                          ToolbarItem(placement: .confirmationAction) {
                              Button("Save") {
                                  isArticleEditViewEnabled = false
                                  articleList.updateData(updatedArticle: editableArticle)
                              }
                          }
                      }
              }
          }
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListItemView(article: FirebaseArticle(
            id: "1", title: "title", lead: "test", description: "tst", imageUrl: "https://d.newsweek.com/en/full/2287157/elon-musk.jpg"
        ))
    }
}
