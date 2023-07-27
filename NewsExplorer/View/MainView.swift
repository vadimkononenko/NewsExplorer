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
            .task {
                await viewModel.getRecentNews()
            }
            .onSubmit(of: .search, {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    handleSearch()
                }
            })
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText, perform: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    handleSearch()
                }
            })
            .sheet(isPresented: $isShowFilters) {
                FiltersView(viewModel: viewModel)
            }
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowFilters.toggle()
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
