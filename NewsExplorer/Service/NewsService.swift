//
//  NewsService.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import Foundation

enum SortingType: String {
    case relevancy
    case popularity
    case publishedAt
}

class NewsService {
    
    static let shared = NewsService()
    private init() {}
    
    enum NewsError: Error {
        case invalidUrl, unableToComplete, invalidData, responseError, decodingProblem, dateRecievingProblem
    }
    
    func getNews() async throws -> [Article] {
        let parametrs = [
            "q": "Apple",
            "apiKey": API_KEY
        ]
        
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw NewsError.invalidUrl
        }
        
        return try await handleRequest(with: url)
    }
    
    func getSortedNews() {
        // TODO: sorted
    }
    
    func searchNews(phrase: String) async throws -> [Article] {
        let parametrs = [
            "q": phrase.isEmpty ? "Apple" : phrase,
            "apiKey": API_KEY
        ]
        
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw NewsError.invalidUrl
        }
        
        return try await handleRequest(with: url)
    }
    
    func searchNews(phrase: String, from fromDate: String, to toDate: String) async throws -> [Article] {
        let parametrs = [
            "q": phrase.isEmpty ? "Apple" : phrase,
            "apiKey": API_KEY,
            "from": fromDate,
            "to": toDate
        ]
        
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw NewsError.invalidUrl
        }
        
        return try await handleRequest(with: url)
    }
    
    private func handleRequest(with url: URL) async throws -> [Article] {
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NewsError.invalidData
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw NewsError.responseError
        }
        
        guard let result = try? JSONDecoder().decode(News.self, from: data) else {
            throw NewsError.decodingProblem
        }
        
        return result.articles
    }
    
}
