//
//  DetailArticleView.swift
//  NewsExplorer
//
//  Created by Vadim Kononenko on 28.07.2023.
//

import SwiftUI

struct DetailArticleView: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(article.source.name)
                    .foregroundColor(Color.black.opacity(0.5))
                    .font(.caption)
                
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 2, height: 2)
                
                if article.author != nil {
                    Text(article.author!)
                        .foregroundColor(Color.black.opacity(0.5))
                        .font(.caption)
                    
                    Circle()
                        .fill(Color.black.opacity(0.5))
                        .frame(width: 2, height: 2)
                }
                
                Text("\(article.formattedPublishedAt)")
                    .foregroundColor(Color.black.opacity(0.5))
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(article.title)
                .font(.title)
            
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .padding(.vertical)
            
            Text(article.description)

            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
}
