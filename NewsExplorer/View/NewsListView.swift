//
//  NewsListView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        if viewModel.articles.isEmpty {
            Text("No results")
                .font(.title2)
        } else {
            List(viewModel.articles, id: \.id) { article in
                ArticleItemView(article: article)
            }
            .listStyle(.plain)
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: MainViewModel())
    }
}
