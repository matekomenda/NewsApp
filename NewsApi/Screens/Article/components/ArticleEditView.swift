//
//  ArticleEditView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 29..
//

import SwiftUI

struct ArticleEditView: View {
    @Binding var firebaseEditArticle: FirebaseArticle
    
    var body: some View {
        Form {
            Section(header: Text("Add Title")) {
                TextField("Enter your title here", text: $firebaseEditArticle.title)
            }
            Section(header: Text("Add Lead")) {
                TextField("Enter your lead here", text: $firebaseEditArticle.lead)
            }
            Section(header: Text("Add Description")) {
                // TextEditor(text: $description)
                TextField("Enter your description here", text: $firebaseEditArticle.description, axis: .vertical)
                    .lineLimit(5...10)
            }
            Section(header: Text("Add photo url")) {
                TextField("Enter your photo url here", text: $firebaseEditArticle.imageUrl)
            }
        }
    }
}

struct ArticleEditView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleEditView(firebaseEditArticle: .constant(FirebaseArticle(id: "", title: "", lead: "", description: "", imageUrl: "")))
    }
}
