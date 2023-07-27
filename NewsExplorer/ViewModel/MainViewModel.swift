//
//  MainViewModel.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    
    private let newsService = NewsService.shared
    
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    @Published var fromDate: String = "2023-07-11"
    @Published var toDate: String = "2023-07-13"
    
    func getRecentNews() async {
        do {
            articles = try await newsService.getNews()
            isLoading = false
        } catch {
            print(error)
        }
    }
    
    func search() async {
        do {
            isLoading = true
            articles = try await newsService.searchNews(phrase: searchText, from: fromDate, to: toDate)
            isLoading = false
        } catch {
            print(error)
        }
    }
    
    func searchForPeriod() async {
        do {
            isLoading = true
            articles = try await newsService.searchNews(phrase: searchText, from: fromDate, to: toDate)
            isLoading = false
        } catch {
            print(error)
        }
    }
    
}
