//
//  NewsModel.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
    
    var id: UUID {
        UUID()
    }
    
    var formattedPublishedAt: String {
        guard let date = try? Date(publishedAt, strategy: .iso8601) else { return ""}
        
        let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        
        return formattedDate
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
