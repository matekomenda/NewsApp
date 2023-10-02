//
//  AddArticleView.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 27..
//

import SwiftUI
import PhotosUI

struct AddArticleView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Binding var firebaseNewArticle: FirebaseArticle
    
    var body: some View {
        Form {
            Section(header: Text("Add Title")) {
                TextField("Enter your title here", text: $firebaseNewArticle.title)
            }
            Section(header: Text("Add Lead")) {
                TextField("Enter your lead here", text: $firebaseNewArticle.lead)
            }
            Section(header: Text("Add Description")) {
                // TextEditor(text: $description)
                TextField("Enter your description here", text: $firebaseNewArticle.description, axis: .vertical)
                    .lineLimit(5...10)
            }
            Section(header: Text("Add photo url")) {
                TextField("Enter your photo url here", text: $firebaseNewArticle.imageUrl)
            }
            
            PhotosPicker("Upload your photo", selection: $avatarItem, matching: .images)
            if let avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
            }
        }
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}


struct AddArticleView_Previews: PreviewProvider {
    static var previews: some View {
        AddArticleView(firebaseNewArticle: .constant(FirebaseArticle(id: "", title: "", lead: "", description: "", imageUrl: "")))
    }
}
