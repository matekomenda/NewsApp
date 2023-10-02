//
//  FirebaseArticleViewModel.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 28..
//

import Foundation
import Firebase

class FirebaseArticleViewModel: ObservableObject {
    @Published var articleList = [FirebaseArticle]()
    
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("articles").getDocuments { snapshot, error in
            
            // Check error
            if error == nil {
                // no error
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        // get all the documents
                        self.articleList = snapshot.documents.map { d in
                            return FirebaseArticle(
                                id: d.documentID,
                                title: d["title"] as? String ?? "",
                                lead: d["lead"] as? String ?? "",
                                description: d["description"] as? String ?? "",
                                imageUrl: d["imageUrl"] as? String ?? "")
                        }
                    }
                }
            } else {
                // handle error
            }
        }
    }
    
    func addData(newArticle: FirebaseArticle) {
        let db = Firestore.firestore()
        
        db.collection("articles").addDocument(
            data: ["title": newArticle.title,
                   "lead": newArticle.lead,
                   "description": newArticle.description,
                   "imageUrl": newArticle.imageUrl
                  ]) { error in
                      // check error
                      if error == nil {
                          // no error
                          self.getData()
                      } else {
                          // handle error
                      }
                  }
    }
    
    func deleteData(deletableArticle: FirebaseArticle){
        let db = Firestore.firestore()
        
        db.collection("articles").document(deletableArticle.id).delete { error in
            if error == nil {
                // no error
                DispatchQueue.main.async {
                    self.articleList.removeAll { article in
                        return article.id == deletableArticle.id
                    }
                }
                
            } else {
                // handle error
            }
        }
        
    }
    
    func updateData(updatedArticle: FirebaseArticle) {
        let db = Firestore.firestore()
        db.collection("articles").document(updatedArticle.id).setData([
            "title": updatedArticle.title,
            "lead": updatedArticle.lead,
            "description": updatedArticle.description,
            "imageUrl": updatedArticle.imageUrl
        ], merge: true) { error in
            if error == nil {
                // no error
                self.getData()
            } else {
                // error handling
            }
        }
    }
}
