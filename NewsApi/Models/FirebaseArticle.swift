//
//  FirebaseArticle.swift
//  NewsApi
//
//  Created by Máté Komenda on 2023. 09. 28..
//

import Foundation

struct FirebaseArticle: Identifiable, Codable {
    var id: String //UUID()
    var title: String
    var lead: String
    var description: String
    var imageUrl: String // || URL
}

extension FirebaseArticle {
    static var emptyNewFirebaseArticle: FirebaseArticle {
        FirebaseArticle(id: "", title: "", lead: "", description: "", imageUrl: "")
    }
}
