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
    @Published var fromDate: Date = (Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date())
    @Published var toDate: Date = Date()
    @Published var sortingSelected: SortingType = .publishedAt
    
    let sortingTypes: [SortingType] = [.publishedAt, .popularity, .relevancy]
    
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
            articles = try await newsService.searchNews(phrase: searchText,
                                                        from: formatDate(date: fromDate),
                                                        to: formatDate(date: toDate),
                                                        sortBy: sortingSelected)
            isLoading = false
        } catch {
            print(error)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        return dateFormatter.string(from: date)
    }
    
}
