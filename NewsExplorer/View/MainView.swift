//
//  MainView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @State private var isShowFilters: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    NewsListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText, perform: { _ in
                handleSearch()
            })
            .onChange(of: viewModel.sortingSelected, perform: { _ in
                handleSearch()
            })
            .sheet(isPresented: $isShowFilters) {
                FiltersView(viewModel: viewModel)
            }
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Period") {
                            isShowFilters.toggle()
                        }
                        
                        Menu("Sort By") {
                            Picker("Sort", selection: $viewModel.sortingSelected) {
                                ForEach(viewModel.sortingTypes, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .tint(.black)
                }
            }
        }
    }
    
    private func handleSearch() {
        Task {
            await viewModel.search()
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
