//
//  ArticleItemView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 27.07.2023.
//

import SwiftUI

struct ArticleItemView: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 15) {
                Rectangle()
                    .fill(Color.red.opacity(0.7))
                    .frame(maxHeight: 45)
                    .frame(width: 4)
                
                Text(article.title)
                    .font(.headline)
                    .padding(.bottom, 10)
            }
            
            Text(article.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .padding(.horizontal, 15)
        }
    }
}
