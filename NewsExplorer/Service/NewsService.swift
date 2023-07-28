//
//  NewsService.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import Foundation

enum SortingType: String, CaseIterable {
    case relevancy
    case popularity
    case publishedAt = "publishedAt"
}

class NewsService {
    
    static let shared = NewsService()
    private init() {}
    
    enum NewsError: Error {
        case invalidUrl, unableToComplete, invalidData, responseError, decodingProblem, dateRecievingProblem
    }
    
    /// This function gets a list of news articles from the news API.
    /// - Returns: A list of articles.
    /// - Throws: `NewsError.invalidUrl` if the URL is invalid.
//    func getNews() async throws -> [Article] {
//        let parametrs = [
//            "q": "Apple",
//            "apiKey": API_KEY
//        ]
//
//        var urlComponents = URLComponents(string: BASE_URL)
//        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
//
//        guard let url = urlComponents?.url else {
//            throw NewsError.invalidUrl
//        }
//
//        return try await handleRequest(with: url)
//    }
    
    /// This function searches for news articles that match the given phrase, and optionally, a date range.
    /// - Parameters:
    ///   - phrase: The phrase to search for.
    ///   - fromDate: The start date of the date range.
    ///   - toDate: The end date of the date range.
    ///   - sorting: The sorting type
    /// - Returns: A list of articles that match the given phrase and date range.
    /// - Throws: `NewsError.invalidUrl` if the URL is invalid.
    func searchNews(phrase: String, from fromDate: String, to toDate: String, sortBy sorting: SortingType) async throws -> [Article] {
        let parametrs = [
            "q": phrase.isEmpty ? "Apple" : phrase,
            "apiKey": API_KEY,
            "from": fromDate,
            "to": toDate,
            "sortBy": sorting.rawValue
        ]
        
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw NewsError.invalidUrl
        }
        
        return try await handleRequest(with: url)
    }
    
    /// This function searches for news articles that match the given phrase, and optionally, a date range.
    /// - Parameters:
    ///   - phrase: The phrase to search for.
    ///   - sorting: The sorting type
    /// - Returns: A list of articles that match the given phrase and date range.
    /// - Throws: `NewsError.invalidUrl` if the URL is invalid.
    func searchNews(phrase: String, sortBy sorting: SortingType) async throws -> [Article] {
        let parametrs = [
            "q": phrase.isEmpty ? "Apple" : phrase,
            "apiKey": API_KEY,
            "sortBy": sorting.rawValue
        ]
        
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            throw NewsError.invalidUrl
        }
        
        return try await handleRequest(with: url)
    }
    
    /// This function handles a request to the news API.
    /// - Parameter url: The URL of the request.
    /// - Returns: A list of articles.
    /// - Throws:
    ///     - `NewsError.invalidData` if the data from the request is invalid.
    ///     - `NewsError.responseError` if the response from the server is invalid.
    ///     - `NewsError.decodingProblem` if there is a problem decoding the data from the server.
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
