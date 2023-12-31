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
    @Published var fromDate: Date = (Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date())
    @Published var toDate: Date = Date()
    @Published var sortingSelected: SortingType = .publishedAt
    
    let sortingTypes: [SortingType] = [.publishedAt, .popularity, .relevancy]
    
    init() {
        Task {
            await search()
        }
    }
    
    func search() async {
        do {
            isLoading = true
            
            if sortingSelected == .publishedAt {
                articles = try await newsService.searchNews(phrase: searchText, sortBy: sortingSelected)
            } else {
                articles = try await newsService.searchNews(phrase: searchText,
                                                            from: formatDate(date: fromDate),
                                                            to: formatDate(date: toDate),
                                                            sortBy: sortingSelected)
            }
            
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
