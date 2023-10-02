//
//  ArticleView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 27..
//

import SwiftUI

struct ArticleView: View {
    @State var newArticle: FirebaseArticle = FirebaseArticle.emptyNewFirebaseArticle
    @State private var isAddArticleViewEnabled = false
    @ObservedObject var articleList: FirebaseArticleViewModel = FirebaseArticleViewModel()
    @State private var searchText = "" // New State for the search text
    
    init() {
        articleList.getData()
    }
    
    func performSearch() {
        // todo finish logic
      }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    TextField("Search", text: $searchText) // Search field
                        .padding(.horizontal, 10)
                        .font(.system(size: 24))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        performSearch()
                    }) {
                        Text("Search")
                    }
                }
                List {
                    ForEach(articleList.articleList) { article in
                        NavigationLink(destination: ArticleDetailView(articleDetail: article, articleList: self.articleList)) {
                            ArticleListItemView(article: article)
                        }
                    }.onDelete { indexSet in
                        if let firstIndex = indexSet.first {
                            let deletableArticle = articleList.articleList[firstIndex]
                            articleList.deleteData(deletableArticle: deletableArticle)
                        }
                    }
                    .listStyle(DefaultListStyle())
                }
            }
            .navigationTitle("Article")
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        isAddArticleViewEnabled = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddArticleViewEnabled) {
                NavigationStack {
                    AddArticleView(firebaseNewArticle: $newArticle)
                        .navigationTitle("Create Article")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isAddArticleViewEnabled = false
                                    newArticle = FirebaseArticle.emptyNewFirebaseArticle
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isAddArticleViewEnabled = false
                                    articleList.addData(newArticle: newArticle)
                                    newArticle = FirebaseArticle.emptyNewFirebaseArticle
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
